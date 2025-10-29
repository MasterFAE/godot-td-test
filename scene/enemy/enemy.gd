class_name Enemy 
extends CharacterBody2D

@export var navigation_target: Node2D;
@export var base_stats : EnemyStats;

@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var path_finding_component: PathfindingComponent = $PathFindingComponent
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var hit_component: HitComponent = $HitComponent

var stats : EnemyStats;

func _ready() -> void:
	stats = base_stats.duplicate(true);
	_init_all_powerups();
	hit_component.setAttackStats(stats.attack_stats)
	hit_component.triggerCollider(false);
	velocity_component.movement_speed = stats.movement_speed;
	
	health_component.setInitialHealth(stats.max_health);
	#path_finding_component.setTargetLocation(navigation_target);

	health_component.onDeath.connect(onDeath)
	hurt_component.onHurt.connect(health_component.dealDamage)
	PowerupManager.onPowerUpAdded.connect(onNewPowerUp);
	
func navigation_target_reached():
	# reduce player health;
	self.queue_free();

func onDeath() -> void:
	self.queue_free();
	var coinDrop = stats.getDropCoin();
	CurrencyManager.collectCoin(coinDrop);
	var xpDrop = stats.getDropXp();
	ExperienceManager.addExperience(xpDrop);
	
func _init_all_powerups() -> void:
	for powerup_type in stats.affecting_powerup_types:
		_apply_powerup(powerup_type)
	
func _apply_powerup(powerup_type: PowerUp.POWERUP_TYPE) -> void:
	match powerup_type:
		PowerUp.POWERUP_TYPE.ENEMY_XP_DROP:
			var minXpDrop = PowerupManager.get_powered_stat(stats.xp_drop_range[0], powerup_type, true);
			var maxXpDrop = PowerupManager.get_powered_stat(stats.xp_drop_range[1], powerup_type, true);
			self.stats.xp_drop_range = Vector2(minXpDrop, maxXpDrop);
		PowerUp.POWERUP_TYPE.ENEMY_GOLD_DROP:
			var minCoinDrop = int(PowerupManager.get_powered_stat(stats.coin_drop_range[0], powerup_type, true));
			var maxCoinDrop = int(PowerupManager.get_powered_stat(stats.coin_drop_range[1], powerup_type, true));
			self.stats.coin_drop_range = Vector2i(minCoinDrop, maxCoinDrop);
	
func onNewPowerUp(powerup: PowerUp) -> void:
	self._apply_powerup(powerup.type)
