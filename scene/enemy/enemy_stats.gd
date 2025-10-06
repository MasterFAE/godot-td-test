class_name EnemyStats
extends Resource

@export_range(1, 10000) var max_health := 100.0;
@export_range(1, 100) var movement_speed := 5.0;
@export var character_name: String;
@export var character_description: String;
@export var character_texture: Texture2D;

#@export_range(0,10) var physical_armor: float = 1;
#@export_range(0,10) var magical_armor: float = 1;
#@export_range(0, 100) var evasion: float = 1;
