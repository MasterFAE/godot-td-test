class_name MouseTracker
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

const TILE_SIZE := 16;

var currentCell : Vector2i;

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	currentCell = Vector2i(floor(mouse_pos.x / TILE_SIZE), floor(mouse_pos.y / TILE_SIZE))
	position = Vector2(currentCell) * TILE_SIZE
