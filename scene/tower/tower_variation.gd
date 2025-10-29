class_name TowerVariation
extends Resource

@export var tower_name : String;
#@export var texture: Texture2D;
#@export var projectile_variation = Resource;
@export_range(5, 100) var projectile_offset := 20;
@export var attack_stats: AttackStats;
@export var build_cost: int = 1;
@export var affecting_powerup_types : Array[PowerUp.POWERUP_TYPE] = [PowerUp.POWERUP_TYPE.TOWER_ATTACK_SPEED, PowerUp.POWERUP_TYPE.TOWER_ATTACK_DAMAGE, PowerUp.POWERUP_TYPE.BUILDING_DISCOUNT];
