#!/bin/bash

#==========================================
# FETCHING LATEST RELEASE AND ITS ASSETS
#=================================================

# Fetching information
current_version=$(cat manifest.json | jq -j '.upstream.version|split("~")[0]')
current_yunohost_package_version=$(cat manifest.json | jq -j '.version|split("~ynh")[1]')
repo=$(cat manifest.json | jq -j '.upstream.code|split("https://github.com/")[1]')
# Some jq magic is needed, because the latest upstream release is not always the latest version (e.g. security patches for older versions)
version=$(curl --silent "https://api.github.com/repos/$repo/releases" | jq -r '.[] | select( .prerelease != true ) | .tag_name' | sort -V | tail -1)
assets=($(curl --silent "https://api.github.com/repos/$repo/releases" | jq -r '[ .[] | select(.tag_name=="'$version'").assets[].browser_download_url ] | join(" ") | @sh' | tr -d "'"))

#fetching info for kepubify
current_version_kepubify=$(sed -n '1p' ./conf/appkepubify.src.default | sed 's/^SOURCE_URL=https:\/\/github.com\/pgaskin\/kepubify\/releases\/download\/v//;s/\/kepubify-linux-__MACH__//')
repo_kepubify="pgaskin/kepubify"
version_kepubify=$(curl --silent "https://api.github.com/repos/$repo_kepubify/releases" | jq -r '.[] | select( .prerelease != true ) | .tag_name' | sort -V | tail -1)
assets_kepubify=($(curl --silent "https://api.github.com/repos/$repo_kepubify/releases" | jq -r '[ .[] | select(.tag_name=="'$version_kepubify'").assets[].browser_download_url ] | join(" ") | @sh' | tr -d "'"))

# Later down the script, we assume the version has only digits and dots
# Sometimes the release name starts with a "v", so let's filter it out.
# You may need more tweaks here if the upstream repository has different naming conventions. 
if [[ ${version:0:1} == "v" || ${version:0:1} == "V" ]]; then
    version=${version:1}
fi
if [[ ${version_kepubify:0:1} == "v" || ${version_kepubify:0:1} == "V" ]]; then
    version_kepubify=${version_kepubify:1}
fi

# Setting up the environment variables
echo "Current version: $current_version"
echo "Latest release from upstream: $version"
echo "VERSION=$version" >> $GITHUB_ENV
echo "REPO=$repo" >> $GITHUB_ENV
echo "Current version for kepubify: $current_version_kepubify"
echo "Latest release from upstream for kepubify: $version_kepubify"
echo "VERSION_KEPUBIFY=$version_kepubify" >> $GITHUB_ENV
echo "REPO_KEPUBIFY=$repo_kepubify" >> $GITHUB_ENV
# For the time being, let's assume the script will fail
echo "PROCEED=false" >> $GITHUB_ENV

# Proceed only if the retrieved version is greater than the current one
update_upstream=1
update_kepubify=1

if ! dpkg --compare-versions "$current_version" "lt" "$version" ; then
    echo "::warning ::No new version available for upstream app"
    update_upstream=0
# Proceed only if a PR for this new version does not already exist
elif git ls-remote -q --exit-code --heads https://github.com/$GITHUB_REPOSITORY.git ci-auto-update-v$version ; then
    echo "::warning ::A branch already exists for this update"
    update_upstream=0
fi

if ! dpkg --compare-versions "$current_version_kepubify" "lt" "$version_kepubify" ; then
    echo "::warning ::No new version available for kepubify"
    update_kepubify=0
# Proceed only if a PR for this new version does not already exist
elif git ls-remote -q --exit-code --heads https://github.com/$GITHUB_REPOSITORY.git ci-update-kepubify-v$version_kepubify ; then
    echo "::warning ::A branch already exists for this kepubify update"
    update_kepubify=0
fi

if [ "$update_kepubify"=0 ] && [ "$update_upstream"=0 ]; then
    echo "::no update : exit"
    exit 0
fi

if [ "$update_upstream"=1 ]; then
    echo "Update upstream"
    # Each release can hold multiple assets (e.g. binaries for different architectures, source code, etc.)
    echo "${#assets[@]} available asset(s)"

#=================================================
# UPDATE SOURCE FILES
#=================================================

# Here we use the $assets variable to get the resources published in the upstream release.
# Here is an example for Grav, it has to be adapted in accordance with how the upstream releases look like.

# Let's loop over the array of assets URLs
    for asset_url in ${assets[@]}; do

        echo "Handling asset at $asset_url"

# Assign the asset to a source file in conf/ directory
# Here we base the source file name upon a unique keyword in the assets url (admin vs. update)
# Leave $src empty to ignore the asset
        case $asset_url in
          *"calibre-web-$version.zip"*)
            src="app"
            ;;
          *)
            src=""
            ;;
        esac

# If $src is not empty, let's process the asset
        if [ ! -z "$src" ]; then

# Create the temporary directory
            tempdir="$(mktemp -d)"

# Download sources and calculate checksum
            filename=${asset_url##*/}
            curl --silent -4 -L $asset_url -o "$tempdir/$filename"
            checksum=$(sha256sum "$tempdir/$filename" | head -c 64)

# Delete temporary directory
            rm -rf $tempdir

            extension=zip
# Rewrite source file

cat <<EOT > conf/$src.src
SOURCE_URL=$asset_url
SOURCE_SUM=$checksum
SOURCE_FORMAT=$extension
EOT
            echo "... conf/$src.src updated"

        else
            echo "... asset ignored"
        fi

    done
fi

if [ "$update_kepubify"=1 ]; then
    echo "Update kepubify"
    for asset_url_kepubify in ${assets_kepubify[@]}; do

        echo "Handling asset at $asset_url_kepubify"

        case $asset_url_kepubify in
          *"linux-32bit"*)
            sha="sha256_32bit"
            src="appkepubify"
            ;;
          *"linux-64bit"*)
            sha="sha256_64bit"
            src="appkepubify"
            ;;
          *"linux-arm"*)
            sha="sha256_arm"
            src="appkepubify"
            ;;
          *"linux-arm64"*)
            sha="sha256_arm64"
            src="appkepubify"
            ;;
          *"linux-armv6"*)
            sha="sha256_armv6"
            src="appkepubify"
            ;;
          *)
            src=""
            ;;
        esac

# If $src is not empty, let's process the asset
        if [ ! -z "$src" ]; then

# Create the temporary directory
            tempdir="$(mktemp -d)"

# Download sources and calculate checksum
            filename=${asset_url##*/}
            curl --silent -4 -L $asset_url -o "$tempdir/$filename"
            checksum=$(sha256sum "$tempdir/$filename" | head -c 64)

# Delete temporary directory
            rm -rf $tempdir
# Rewrite source file

cat <<EOT > conf/$src.src.default
SOURCE_URL=https://github.com/pgaskin/kepubify/releases/download/v$version_kepubify/kepubify-linux-__MACH__
SOURCE_SUM=__SHA256__
SOURCE_EXTRACT=false
SOURCE_FILENAME=kepubify-linux-__MACH__
EOT
            echo "... conf/$src.src updated"
#rewrite sha256sum
            sed -i 's/^$sha=.*/$sha=$checksum/' ./scripts/_common.sh
            echo "... ./scripts/_common.sh updated for $sha"
        else
            echo "... asset ignored"
        fi

    done



fi

#=================================================
# GENERIC FINALIZATION
#=================================================
if [ "$update_upstream"=1 ]; then
# Replace new version in manifest
    echo "$(jq -s --indent 4 ".[] | .version = \"$version~ynh1\"" manifest.json)" > manifest.json
    echo "$(jq -s --indent 4 ".[] | .upstream.version = \"$version\"" manifest.json)" > manifest.json
fi
if [ "$update_kepubify"=1 ] && [ "$update_upstream"=0 ]; then
new_yunohost_package_version=$(("$current_yunohost_package_version+1"))
    echo "$(jq -s --indent 4 ".[] | .version = \"$version~ynh$new_yunohost_package_version\"" manifest.json)" > manifest.json
fi

# The Action will proceed only if the PROCEED environment variable is set to true
echo "PROCEED=true" >> $GITHUB_ENV
exit 0
