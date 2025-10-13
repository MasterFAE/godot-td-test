extends Node2D

const TILE_SIZE := 16;

var currentCell : Vector2i;

func _process(_delta: float) -> void:
	var newPos = get_global_mouse_position().snapped(Vector2(TILE_SIZE, TILE_SIZE))
	position = get_global_mouse_position().snapped(Vector2(TILE_SIZE, TILE_SIZE));
	currentCell = Vector2i(newPos.x / TILE_SIZE, newPos.y / TILE_SIZE);
