class_name Tower
extends StaticBody2D

@export var base_tower_stats: TowerResource;
@export var tower_projectile: PackedScene;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var projectiles: Node = $Projectiles
@onready var attack_component: AttackComponent = $AttackComponent
const TOWER_ATTACK_SPEED_I = preload("uid://kp0hpj8hgoy0")
const TOWER_ATTACK_DAMAGE_I = preload("uid://cgi0oi1q15byh")
const BUILD_DISCOUNT_I = preload("uid://31tyqw5gpqk4")
const ENEMY_GOLD_DROP_TEST = preload("uid://b7h8cqrkxlodt")
const ENEMY_XP_DROP_TEST = preload("uid://cxiwm8khfcyyl")
const PLAYER_UNIT_ATTACK_DAMAGE_TEST = preload("uid://brhntn8kgv77d")
const PLAYER_UNIT_HEALTH_TEST = preload("uid://dj2pr45tabm8h")

var tower_stats: TowerResource;

func _ready() -> void:
	tower_stats = base_tower_stats.duplicate(true);
	_init_all_powerups();
	attack_component.setAttackCooldown(tower_stats.attack_stats.attack_cooldown);
	attack_component.onAttacked.connect(_fire_projectile)
	PowerupManager.onPowerUpAdded.connect(self.onNewPowerUp);
	PowerupManager.add_powerup(PLAYER_UNIT_HEALTH_TEST)
	PowerupManager.add_powerup(PLAYER_UNIT_ATTACK_DAMAGE_TEST)
	#range_collider.shape.radius = tower_stats.attack_range * 64;
	
func _fire_projectile(enemy: CharacterBody2D) -> void:
	var _projectile = tower_projectile.instantiate() as Projectile;
	_projectile.target = enemy;
	_projectile.call_deferred("setHitComponentAttackStats", tower_stats.attack_stats);
	_projectile.global_position = Vector2(global_position.x, global_position.y - 15);
	projectiles.add_child(_projectile);
	
func _init_all_powerups() -> void:
	for powerup_type in tower_stats.affecting_powerup_types:
		_apply_powerup(powerup_type)
	
func _apply_powerup(powerup_type: PowerUp.POWERUP_TYPE) -> void:
	match powerup_type:
		PowerUp.POWERUP_TYPE.TOWER_ATTACK_DAMAGE:
			tower_stats.attack_stats.attack_damage = PowerupManager.get_powered_stat(base_tower_stats.attack_stats.attack_damage, powerup_type, true);
		PowerUp.POWERUP_TYPE.TOWER_ATTACK_SPEED:
			tower_stats.attack_stats.attack_cooldown = PowerupManager.get_powered_stat(base_tower_stats.attack_stats.attack_cooldown, powerup_type, false);
			attack_component.setAttackCooldown(tower_stats.attack_stats.attack_cooldown);
		PowerUp.POWERUP_TYPE.BUILDING_DISCOUNT:
			tower_stats.build_cost = int(PowerupManager.get_powered_stat(base_tower_stats.build_cost, powerup_type, true));
	
func onNewPowerUp(powerup: PowerUp) -> void:
	self._apply_powerup(powerup.type)
