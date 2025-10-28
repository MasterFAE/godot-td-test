class_name EnemyStats
extends Resource

@export_range(1, 10000) var max_health := 100.0;
@export_range(0, 200) var movement_speed := 10.0;
@export var character_name: String;
@export var character_description: String;
@export var attack_stats: AttackStats;
@export var coin_drop_range: Vector2i;
@export var xp_drop_range: Vector2;

func getDropCoin() -> int:
	return randi_range(self.coin_drop_range[0], self.coin_drop_range[1]);
	
func getDropXp() -> float:
	return randf_range(self.xp_drop_range[0], self.xp_drop_range[1]);

#@export_range(0,10) var physical_armor: float = 1;
#@export_range(0,10) var magical_armor: float = 1;
#@export_range(0, 100) var evasion: float = 1;
