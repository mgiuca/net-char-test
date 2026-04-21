extends Node2D

@export var locally_controlled_player : Player

func _physics_process(_delta: float) -> void:
  var direction := Input.get_vector('left', 'right', 'up', 'down')
  if locally_controlled_player:
    locally_controlled_player.move(direction)


func _on_button_pressed() -> void:
  print_message.rpc()

@rpc
func print_message() -> void:
  print('Hello this is a message')
