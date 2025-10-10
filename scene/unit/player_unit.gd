class_name PlayerUnit
extends CharacterBody2D

@export var stats: PlayerUnitStats;
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var hit_component: HitComponent = $HitComponent

func _ready():
	hit_component.triggerCollider(false);
	health_component.setInitialHealth(stats.max_health);
	hurt_component.onHurt.connect(health_component.dealDamage)
	health_component.onDeath.connect(_onDeath);

func _onDeath():
	self.queue_free();

func _on_attack_component_on_attacked(_target: CharacterBody2D) -> void:
	print("attacking at: ", _target.name)
	hit_component.setColliderPosition(_target.global_position);
	hit_component.damage = stats.attack_stats._calculate_damage();
	hit_component.triggerCollider(false);
	await get_tree().create_timer(1.0).timeout
	hit_component.triggerCollider(true);
