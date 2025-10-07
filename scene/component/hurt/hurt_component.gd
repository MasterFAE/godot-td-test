class_name HurtComponent
extends Area2D

signal onHurt

func _on_body_entered(body: Node2D) -> void:
	if(body is Projectile):
		var projectile = body as Projectile;
		onHurt.emit(projectile.damage);
		#health_component.dealDamage(projectile.damage)
		projectile.queue_free();
		



func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
