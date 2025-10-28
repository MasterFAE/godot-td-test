class_name Tower
extends StaticBody2D

@export var base_tower_variant: TowerVariation;
@export var tower_projectile: PackedScene;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var projectiles: Node = $Projectiles
@onready var attack_component: AttackComponent = $AttackComponent
const TOWER_ATTACK_SPEED_I = preload("uid://kp0hpj8hgoy0")
const TOWER_ATTACK_DAMAGE_I = preload("uid://cgi0oi1q15byh")
const BUILD_DISCOUNT_I = preload("uid://31tyqw5gpqk4")

var tower_variant_runtime: TowerVariation;

func _ready() -> void:
	tower_variant_runtime = base_tower_variant.duplicate(true);
	attack_component.setAttackCooldown(tower_variant_runtime.attack_stats.attack_cooldown);
	attack_component.onAttacked.connect(_fire_projectile)
	PowerupManager.onPowerUpAdded.connect(self.onNewPowerUp);
	PowerupManager.add_powerup(TOWER_ATTACK_SPEED_I)
	PowerupManager.add_powerup(TOWER_ATTACK_DAMAGE_I)
	PowerupManager.add_powerup(BUILD_DISCOUNT_I)
	#range_collider.shape.radius = tower_variant_runtime.attack_range * 64;
	
func _fire_projectile(enemy: CharacterBody2D) -> void:
	var _projectile = tower_projectile.instantiate() as Projectile;
	_projectile.target = enemy;
	_projectile.call_deferred("setHitComponentAttackStats", tower_variant_runtime.attack_stats);
	_projectile.global_position = Vector2(global_position.x, global_position.y - 15);
	projectiles.add_child(_projectile);

func onNewPowerUp(powerup: PowerUp) -> void:
	var type = powerup.type;
	match type:
		PowerUp.POWERUP_TYPE.TOWER_ATTACK_DAMAGE:
			tower_variant_runtime.attack_stats.attack_damage = PowerupManager.get_powered_stat_by_powerup(base_tower_variant.attack_stats.attack_damage, powerup);
		PowerUp.POWERUP_TYPE.TOWER_ATTACK_SPEED:
			tower_variant_runtime.attack_stats.attack_cooldown = PowerupManager.get_powered_stat_by_powerup(base_tower_variant.attack_stats.attack_cooldown, powerup);
			attack_component.attack_timer.wait_time = tower_variant_runtime.attack_stats.attack_cooldown;
		PowerUp.POWERUP_TYPE.BUILDING_DISCOUNT:
			tower_variant_runtime.build_cost = int(PowerupManager.get_powered_stat_by_powerup(base_tower_variant.build_cost, powerup));
	Log.pr("Received powerup", powerup);
	
