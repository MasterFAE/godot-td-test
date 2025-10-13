extends NodeState
@onready var attack_component: AttackComponent = $"../../AttackComponent"
@onready var hit_component: HitComponent = $"../../HitComponent"
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

const ATTACK_TIME := 0.4;
var isAttacking = false;

func _on_next_transitions() -> void:
	if(!isAttacking && attack_component.getCurrentEnemy() == null):
		transition.emit("Idle");


func _on_enter() -> void:
	self._on_attack_component_on_attacked(attack_component.getCurrentEnemy());


func _on_exit() -> void:
	pass

func _on_attack_component_on_attacked(_target: CharacterBody2D) -> void:
	isAttacking = true;
	animated_sprite_2d.play("attack");
	hit_component.setColliderPosition(_target.global_position);
	hit_component.triggerCollider(true);
	await get_tree().create_timer(ATTACK_TIME).timeout
	isAttacking = false;
