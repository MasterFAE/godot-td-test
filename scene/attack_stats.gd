class_name AttackStats
extends Resource

@export_range(1, 100) var attack_damage := 1.0;
@export_range(0.1, 100) var attack_cooldown := 1.0;
@export_range(0, 100) var crit_rate := 0.0;
@export_range(1,10) var crit_multiplier := 1.0;

func _calculate_damage() -> float:
	var damage = attack_damage;
	var crit_random_rate = randf() * 100;
	if(crit_rate > crit_random_rate):
		damage *= crit_multiplier;
	return damage;
