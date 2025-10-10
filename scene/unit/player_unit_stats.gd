class_name PlayerUnitStats
extends Resource

@export var unit_name : String;
@export_range(1, 10000) var max_health := 100.0;
@export var attack_stats : AttackStats;
