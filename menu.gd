extends Control

@onready var lbl_my_ip : Label = %LblMyIP
@onready var txt_join_ip : LineEdit = %TxtJoinIP

@onready var accept_dialog : AcceptDialog = $AcceptDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  lbl_my_ip.text = Globals.get_my_ip()

func _on_btn_host_pressed() -> void:
  print('Hosting game')
  var peer := ENetMultiplayerPeer.new()
  var e := peer.create_server(Globals.PORT, Globals.MAX_CLIENTS)
  if e != Error.OK:
    show_dialog('Connection error', 'Could not connect to server')
    return

  multiplayer.multiplayer_peer = peer
  get_tree().change_scene_to_file('res://level.tscn')

func _on_btn_join_pressed() -> void:
  var ip := txt_join_ip.text
  print('Attempting to connect to %s' % ip)

  var peer := ENetMultiplayerPeer.new()
  var e := peer.create_client(ip, Globals.PORT)
  if e != Error.OK:
    show_dialog('Connection error', 'Could not connect to server')
    return

  multiplayer.multiplayer_peer = peer
  get_tree().change_scene_to_file('res://level.tscn')

func show_dialog(title: String, message: String) -> void:
  accept_dialog.title = title
  accept_dialog.dialog_text = message
  accept_dialog.show()
