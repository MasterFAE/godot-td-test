class_name TowerVariation
extends Resource

@export var tower_name : String;
#@export var texture: Texture2D;
#@export var projectile_variation = Resource;
@export_range(5, 100) var projectile_offset := 20;

@export var attack_stats: AttackStats;
