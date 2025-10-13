class_name HitComponent
extends Area2D

var damage := 0.0;
@export var destroyOnCollision := true;
var attack_stats : AttackStats;

var collider = CollisionShape2D;

func _ready() -> void:
	for children in self.get_children():
		if(children is CollisionShape2D):
			self.collider = children as CollisionShape2D;
	if(collider == null):
		printerr("Collider cannot found in HitComponent")
		
func _on_area_entered(area: Area2D) -> void:
	if area is not HurtComponent:
		return;
		
	var hurt_component = area as HurtComponent;

	hurt_component.onHurt.emit(self.getDamage());
	self.call_deferred("triggerCollider", false)
	if(self.destroyOnCollision):
		self.get_parent().queue_free();

func triggerCollider(enabled: bool):
	print("hit component collider state ", enabled)
	if collider:
		collider.disabled = !enabled

func setColliderPosition(targetPosition: Vector2):
	self.global_position = targetPosition;
	
func setAttackStats(_attack_stats: AttackStats):
	self.attack_stats = _attack_stats;
	
func getDamage():
	return attack_stats._calculate_damage();
