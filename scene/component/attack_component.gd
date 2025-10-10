class_name AttackComponent
extends Area2D

@export var enemy_groups: Array[String];
@onready var attack_timer: Timer = $AttackTimer

signal onAttacked(target: CharacterBody2D)

var enemies_in_range : Array[CharacterBody2D] = [];

func setAttackCooldown(attack_cooldown: float):
	attack_timer.wait_time = attack_cooldown
	attack_timer.autostart = true;

func _on_body_entered(body: Node2D) -> void:
	if(body is not CharacterBody2D): 
		return;
	
	var enemy = body as CharacterBody2D;
	var isEnemy = _is_target_in_enemy_group(enemy);
	if(!isEnemy):
		return;
		
	enemies_in_range.push_back(enemy);
	if(attack_timer.paused):
		attack_timer.paused = false;

func _on_body_exited(body: Node2D) -> void:
	if(body is not CharacterBody2D): 
		return;
	
	var enemy = body as CharacterBody2D;
	var isEnemy = _is_target_in_enemy_group(enemy);
	if(!isEnemy):
		return;
		
	enemies_in_range.pop_front();
	
	
func _is_target_in_enemy_group(target: CharacterBody2D) -> bool:
	var bodyGroup = target.get_groups();
	var isEnemy = false;
	
	for _group in bodyGroup:
		if(enemy_groups.has(_group)):
			isEnemy = true;
			break;
	
	return isEnemy;

func _on_attack_timer_timeout() -> void:
	if(enemies_in_range.is_empty()):
		attack_timer.paused = true;
		return;
		
	var current_enemy = enemies_in_range[0];
	if(current_enemy):
		onAttacked.emit(current_enemy)
