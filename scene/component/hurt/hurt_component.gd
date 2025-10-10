class_name HurtComponent
extends Area2D

signal onHurt

#func _on_body_entered(body: Node2D) -> void:
	#if(body is Projectile):
		#var projectile = body as Projectile;
		#onHurt.emit(projectile.damage);
		##health_component.dealDamage(projectile.damage)
		#projectile.queue_free();
		#

func _on_area_entered(area: Area2D) -> void:
	print("area entered")
	if area is not HitComponent:
		return;
		
	var hit_component = area as HitComponent;
	if(hit_component.get_parent() == self.get_parent()):
		return;
		
	onHurt.emit(hit_component.damage);
	if(hit_component.destroyOnCollision):
		hit_component.get_parent().queue_free();
