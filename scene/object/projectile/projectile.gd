class_name Projectile
extends CharacterBody2D

@export var projectile_variation : ProjectileVariation;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hit_component: HitComponent = $HitComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent

var target: Enemy
var damage := 0;

func _ready() -> void:
	sprite_2d.texture = projectile_variation.projectile_texture;
	sprite_2d.scale = Vector2(0.03, 0.03);
	hit_component.damage = damage;
	velocity_component.movement_speed = projectile_variation.projectile_speed;

func _physics_process(_delta: float) -> void:
	if(target == null):
		queue_free();
		return
		
	var direction = global_position.direction_to(target.global_position)
	look_at(target.global_position);
	velocity_component.moveToDirection(direction);
