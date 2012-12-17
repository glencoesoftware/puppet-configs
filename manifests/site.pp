# site.pp
# first file parsed by puppet
# global scope
# not much should be here --ckm
node default {
  if ($server_tags) {
    unless ($server_tags == 'role:none') {
      $classes = split($server_tags, ',')
      include $classes
    }
  }
  hiera_include(classes, nil)
}
