@tool
class_name Player
extends CharacterBody2D

const MAX_SPEED = 300.0

@onready var visual : Sprite2D = $Visual

@export var sprite_texture : Texture2D:
  set(value):
    sprite_texture = value
    if visual:
      visual.texture = sprite_texture

func _ready() -> void:
  visual.texture = sprite_texture

func move(direction: Vector2) -> void:
  velocity = direction * MAX_SPEED

  move_and_slide()
