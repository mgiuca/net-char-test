extends Node2D

@onready var player_1 : Player = $Player1
@onready var player_2 : Player = $Player2

@export var locally_controlled_player : Player

@onready var wait_scrim : PanelContainer = $UI/WaitScrim

func _ready() -> void:
  multiplayer.peer_connected.connect(_on_peer_connected)

  if multiplayer.is_server():
    # The server always controls player 1.
    locally_controlled_player = player_1
    hide_wait_scrim()
    print('Controlling player 1')

func _physics_process(_delta: float) -> void:
  var direction := Input.get_vector('left', 'right', 'up', 'down')
  if locally_controlled_player:
    locally_controlled_player.move(direction)

func hide_wait_scrim() -> void:
  wait_scrim.hide()

func _on_peer_connected(id: int) -> void:
  if multiplayer.is_server():
    # Give control of Player 2 to the connecting player.
    print('Giving control of player 2 to %d' % id)
    hand_authority_to.rpc(player_2.get_path(), id)

## Transfers multiplayer authority of a node to a given peer.
@rpc('authority', 'call_local')
func hand_authority_to(node_path: NodePath, peer: int) -> void:
  var node := get_tree().root.get_node(node_path)
  print('%s.set_multiplayer_authority(%d)' % [node.get_path(), peer])
  node.set_multiplayer_authority(peer)

  # If this is being transferred to me, set this as the locally controlled player.
  if node is Player and peer == multiplayer.get_unique_id():
    locally_controlled_player = node
    hide_wait_scrim()
    print('Controlling player 2')
