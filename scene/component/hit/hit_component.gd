class_name HitComponent
extends Area2D

var damage := 0.0;
@export var destroyOnCollision := true;
var collider = CollisionShape2D;

func _ready() -> void:
	for children in self.get_children():
		if(children is CollisionShape2D):
			self.collider = children as CollisionShape2D;
	if(collider == null):
		printerr("Collider cannot found in HitComponent")

func triggerCollider(enabled: bool):
	collider.disabled = !enabled;

func setColliderPosition(targetPosition: Vector2):
	self.global_position = targetPosition;
