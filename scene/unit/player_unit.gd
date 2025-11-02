class_name PlayerUnit
extends CharacterBody2D

@export var base_stats: PlayerUnitStats;
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var hit_component: HitComponent = $HitComponent

var unit_stats : PlayerUnitStats;

func _ready():
	unit_stats = base_stats.duplicate(true);
	_init_all_powerups();
	hit_component.setAttackStats(unit_stats.attack_stats)
	hit_component.triggerCollider(false);
	health_component.setInitialHealth(unit_stats.max_health);
	hurt_component.onHurt.connect(health_component.dealDamage)
	health_component.onDeath.connect(_onDeath);

func _onDeath():
	self.queue_free();

func _init_all_powerups() -> void:
	for powerup_type in unit_stats.affecting_powerup_types:
		_apply_powerup(powerup_type)
	
func _apply_powerup(powerup_type: PowerUp.POWERUP_TYPE) -> void:
	match powerup_type:
		PowerUp.POWERUP_TYPE.UNIT_ATTACK_DAMAGE:
			unit_stats.attack_stats.attack_damage = PowerupManager.get_powered_stat(unit_stats.attack_stats.attack_damage, powerup_type, true);
			hit_component.setAttackStats(unit_stats.attack_stats)
		PowerUp.POWERUP_TYPE.UNIT_HEALTH:
			unit_stats.max_health = PowerupManager.get_powered_stat(unit_stats.max_health, powerup_type, true);
			health_component.setInitialHealth(unit_stats.max_health);
	
func onNewPowerUp(powerup: PowerUp) -> void:
	self._apply_powerup(powerup.type)
