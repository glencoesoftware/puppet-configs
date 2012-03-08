# site.pp
# first file parsed by puppet
# global scope
# not much should be here --ckm
node default {
  notice "${fqdn} server_roles:${server_tags}"
  include truth::enforcer
}
