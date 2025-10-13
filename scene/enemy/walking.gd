extends NodeState
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var path_finding_component: PathfindingComponent = $"../../PathFindingComponent"

func _on_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	path_finding_component.velocity_component.is_moving = true;
	animated_sprite_2d.play("walk");

func _on_exit() -> void:
	path_finding_component.velocity_component.is_moving = false;
	animated_sprite_2d.stop()

func _on_attack_component_on_attacked(_target: CharacterBody2D) -> void:
	self.transition.emit("Attack")
