which keychain >/dev/null && keychain id_rsa
[ -z "$HOSTNAME" ] && HOSTNAME=$(uname -n)
[ -f $HOME/.keychain/$HOSTNAME-sh ] && . $HOME/.keychain/$HOSTNAME-sh
#[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && . $HOME/.keychain/$HOSTNAME-sh-gpg

# vim:filetype=sh:
