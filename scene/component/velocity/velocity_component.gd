class_name VelocityComponent
extends Node

@export var character_body: CharacterBody2D;
@export var block_diagonal_movement := false;

var movement_speed: float;
var is_moving := true;

func moveToDirection(direction: Vector2) -> void:
	if(!is_moving):
		character_body.velocity = Vector2.ZERO;
		character_body.move_and_slide();
		return;
		
	var _velocity : Vector2 = direction;
	if(self.block_diagonal_movement):
		if abs(direction.x) > abs(direction.y):
			_velocity.y = 0
		else:
			_velocity.x = 0
			
	character_body.velocity = _velocity.normalized() * movement_speed;
	character_body.move_and_slide();
