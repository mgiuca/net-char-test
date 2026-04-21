class_name Globals
extends Object

const PORT : int = 28744
const MAX_CLIENTS : int = 1

static func get_my_ip() -> String:
  var ipv4_re := RegEx.create_from_string(r'^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
  for interface in IP.get_local_interfaces():
    var interface_name : String = interface['name']
    # Not a "virtual" IP address (on Linux).
    if interface_name.begins_with('virbr'):
      continue
    for addr : String in interface['addresses']:
      # Not IPv6.
      if not ipv4_re.search(addr):
        continue
      # Not localhost.
      if addr == '127.0.0.1':
        continue

      # Return the first address that meets the above criteria.
      return addr

  return ''
