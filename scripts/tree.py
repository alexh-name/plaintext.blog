#!/usr/bin/env python
# inspired by https://stackoverflow.com/a/7406359

import os

def walk(d, ident='  '):
  for p in os.listdir(d):
    fullpath = os.path.join(d, p)
    if p.endswith('.html'):
      print ident + '  <li><a href="' + fullpath + '">' + p + '</a></li>'
    if os.path.isdir(fullpath):
      print ident + '<li>' + p
      print ident + '  <ul>'
      walk(fullpath, ident+'  ')
      print ident + '  </ul>'
      print ident + '</li>'

print '<ul>'
walk(".")
print '</ul>'

