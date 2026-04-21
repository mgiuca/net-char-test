extends Node

const PORT : int = 28744
const MAX_CLIENTS : int = 1

func _ready() -> void:
  multiplayer.peer_connected.connect(_on_peer_connected)
  multiplayer.peer_disconnected.connect(_on_peer_disconnected)
  multiplayer.connected_to_server.connect(_on_connected_to_server)
  multiplayer.connection_failed.connect(_on_connection_failed)
  multiplayer.server_disconnected.connect(_on_server_disconnected)

func start_host_game() -> Error:
  print('Hosting game')
  var peer := ENetMultiplayerPeer.new()
  var e := peer.create_server(PORT, MAX_CLIENTS)
  if e != Error.OK:
    return e

  multiplayer.multiplayer_peer = peer
  return Error.OK

func start_join_game(ip: String) -> Error:
  print('Attempting to connect to %s' % ip)

  var peer := ENetMultiplayerPeer.new()
  var e := peer.create_client(ip, PORT)
  if e != Error.OK:
    return e

  multiplayer.multiplayer_peer = peer
  return Error.OK

func get_my_ip() -> String:
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

func _on_peer_connected(id: int) -> void:
  print('Peer connected: %d' % id)

func _on_peer_disconnected(id: int) -> void:
  print('Peer disconnected: %d' % id)

# Client signals

func _on_connected_to_server() -> void:
  print('Connected to server')
  print('My ID: %d' % multiplayer.get_unique_id())

func _on_connection_failed() -> void:
  print('Connection failed')

func _on_server_disconnected() -> void:
  print('Server disconnected')
