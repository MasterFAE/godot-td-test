class_name Projectile
extends CharacterBody2D

@export var projectile_variation : ProjectileVariation;
@onready var sprite_2d: Sprite2D = $Sprite2D

var target: Enemy
var damage := 0;
var projectile_speed := 0.0;

func _ready() -> void:
	sprite_2d.texture = projectile_variation.projectile_texture;
	sprite_2d.scale = Vector2(0.03, 0.03);
	projectile_speed = projectile_variation.projectile_speed;

func _physics_process(_delta: float) -> void:
	if(target == null):
		queue_free();
		return
	look_at(target.global_position);
	velocity = global_position.direction_to(target.global_position) * projectile_speed;
	move_and_slide()
