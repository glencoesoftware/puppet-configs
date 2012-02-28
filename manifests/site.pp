# site.pp
# first file parsed by puppet
# global scope
# not much should be here --ckm
node default {
  include truth::detector
}
