# site.pp
# first file parsed by puppet
# global scope
# not much should be here --ckm
node default {
  $classes = split($server_tags, ',')
  include $classes
}
