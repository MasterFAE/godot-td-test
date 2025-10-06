class_name Projectile
extends RigidBody2D

@export var projectile_variation : ProjectileVariation;
var target: Enemy
var damage := 0;

func _process(delta: float) -> void:
	if(target == null):
		return;
	
	# calculate direction of projectile
	# by subtracting current position and enemy position	
	print_debug(self.name , " projectile is moving");
	return;
