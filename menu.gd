extends Control

@onready var lbl_my_ip : Label = %LblMyIP
@onready var txt_join_ip : LineEdit = %TxtJoinIP

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  # TODO: Get my IP address in lbl_my_ip.
  pass

func _on_btn_host_pressed() -> void:
  get_tree().change_scene_to_file('res://level.tscn')

func _on_btn_join_pressed() -> void:
  var ip := txt_join_ip.text
  print('Attempting to connect to %s' % ip)
  # TODO
