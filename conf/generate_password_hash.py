#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Permet de générer le hash pour le password
#Plus utilisé depuis la MAJ 0.92~ynh3 avec LDAP
import sys
path=sys.argv[2]
sys.path.append(path)
from werkzeug.security import generate_password_hash
password=sys.argv[1]
print generate_password_hash(password)
