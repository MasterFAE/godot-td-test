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
	if(area is HitComponent):
		var hit_component = area as HitComponent;
		onHurt.emit(hit_component.damage);
		hit_component.get_parent().queue_free();
