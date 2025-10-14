extends NodeState

@export var attack_component: AttackComponent
@export var hit_component: HitComponent
@export var animated_sprite_2d: AnimatedSprite2D

@export var attack_time := 0.4;
var isAttacking = false;

func _on_next_transitions() -> void:
	if(!isAttacking && attack_component.getCurrentEnemy() == null):
		transition.emit("Idle");


func _on_enter() -> void:
	if(attack_component.getCurrentEnemy() != null):
		self._on_attack_component_on_attacked(attack_component.getCurrentEnemy());

func _on_exit() -> void:
	pass

func _on_attack_component_on_attacked(_target: CharacterBody2D) -> void:
	isAttacking = true;
	animated_sprite_2d.play("attack");
	animated_sprite_2d.flip_h = _target.global_position.x <= animated_sprite_2d.global_position.x
	hit_component.setColliderPosition(_target.global_position);
	hit_component.triggerCollider(true);
	await get_tree().create_timer(attack_time).timeout
	isAttacking = false;
