#!/usr/bin/env python

import difflib
import hashlib
import os
import shutil
import sys

NORMAL      = '\033[0m'
BOLD        = '\033[1m'
RED         = '\033[31m'
GREEN       = '\033[32m'
BOLD_RED    = '\033[1;31m'
BOLD_GREEN  = '\033[1;32m'

EXCLUDE = ['README', os.path.basename(sys.argv[0])]
home = os.getenv('HOME')

def green(s):
    return GREEN + s + NORMAL

def red(s):
    return RED + s + NORMAL

def bold_green(s):
    return BOLD_GREEN + s + NORMAL

def bold_red(s):
    return BOLD_RED + s + NORMAL

def bold(s):
    return BOLD + s + NORMAL

def format_diff(l):
    l = l.rstrip()
    if l.startswith('---'):
        return bold_red(l)
    elif l.startswith('+++'):
        return bold_green(l)
    elif l.startswith('-'):
        return red(l)
    elif l.startswith('+'):
        return green(l)
    else:
        return l

for root, dirs, files in os.walk('.'):
    if root == '.':
        files = list(set(files) - set(EXCLUDE))
    for d in dirs:
        if d.startswith('.'):
            dirs.remove(d)
    for f in files:
        if f.startswith('.'):
            continue
        p1 = os.path.join(root, f)
        if root == '.':
            p2 = os.path.join(home, '.' + f)
        else:
            p2 = os.path.join(home, '.' + root[2:], f)
        if os.path.exists(p2):
            h2 = hashlib.sha1(open(p2).read()).digest()
        else:
            print bold('\n==> %s does not exist' % p2)
            ans = raw_input('Install current version ? [Y|n] ')
            if ans.lower() in [ '', 'y' ]:
                dir = os.path.dirname(p2)
                if not os.path.exists(dir):
                    os.makedirs(dir)
                shutil.copyfile(p1, p2)
            continue
        h1 = hashlib.sha1(open(p1).read()).digest()
        if h1 == h2:
            continue

        print bold('\n==> %s and %s are different' % \
            (p1, p2.replace(home, '~')))

        ans = 'd'
        while ans == 'd':
            while True:
                print '\nYou can:'
                print '    k) Keep local version without modifying VCS version'
                print '    i) Install version in version control'
                print '    u) Use local version and copy it in VCS'
                print '    d) Show diff'
                ans = raw_input('Your choice: [K|i|u|d] ')
                ans = ans.lower()
                if ans in ('', 'k', 'i', 'u', 'd'):
                    break
        
            if ans == 'i':
                shutil.copyfile(p1, p2)
            elif ans == 'u':
                shutil.copyfile(p2, p1)
            elif ans == 'd':
                d = difflib.unified_diff(open(p2, 'rt').readlines(),
                                         open(p1, 'rt').readlines(),
                                         p2.replace(home, '~'),
                                         p1)
                print '\n'.join([format_diff(l) for l in d])

# vim:et:sw=4:ts=4:
