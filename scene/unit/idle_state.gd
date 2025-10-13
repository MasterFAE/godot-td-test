extends NodeState
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var attack_component: AttackComponent = $"../../AttackComponent"

func _on_physics_process(_delta : float) -> void:
	animated_sprite_2d.play("idle");

func _on_exit() -> void:
	animated_sprite_2d.stop()

func _on_attack_component_on_attacked(_target: CharacterBody2D) -> void:
	self.transition.emit("Attack");
