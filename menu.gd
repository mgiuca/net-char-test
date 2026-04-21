extends Control

@onready var lbl_my_ip : Label = %LblMyIP
@onready var txt_join_ip : LineEdit = %TxtJoinIP

@onready var accept_dialog : AcceptDialog = $AcceptDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  lbl_my_ip.text = NetManager.get_my_ip()

func _on_btn_host_pressed() -> void:
  var e := NetManager.start_host_game()
  if e != Error.OK:
    show_dialog('Connection error', 'Could not connect to server')
    return

  get_tree().change_scene_to_file('res://level.tscn')

func _on_btn_join_pressed() -> void:
  var ip := txt_join_ip.text
  var e := NetManager.start_join_game(ip)
  if e != Error.OK:
    show_dialog('Connection error', 'Could not connect to server')
    return

  get_tree().change_scene_to_file('res://level.tscn')

func _on_txt_join_ip_text_submitted(_new_text: String) -> void:
  _on_btn_join_pressed()

func show_dialog(title: String, message: String) -> void:
  accept_dialog.title = title
  accept_dialog.dialog_text = message
  accept_dialog.show()
