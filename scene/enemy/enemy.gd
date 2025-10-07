class_name Enemy 
extends CharacterBody2D

@export var navigation_target: Node2D;
@export var stats : EnemyStats;

@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var path_finding_component: PathfindingComponent = $PathFindingComponent
@onready var hurt_component: HurtComponent = $HurtComponent

func _ready() -> void:
	sprite_2d.texture = stats.character_texture;
	velocity_component.movement_speed = stats.movement_speed;
	
	health_component.setInitialHealth(stats.max_health);
	path_finding_component.setTargetLocation(navigation_target);

	health_component.onDeath.connect(onDeath)
	hurt_component.onHurt.connect(health_component.dealDamage)
	
func navigation_target_reached():
	# reduce player health;
	self.queue_free();
	pass;

func onDeath() -> void:
	self.queue_free();
	var coinDrop = randi_range(stats.minCoin, stats.maxCoin);
	CurrencyManager.collectCoin(coinDrop);
