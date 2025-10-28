class_name PowerUp
extends Resource

@export var display_name: String = "";
@export var description: String = "";
@export var icon: Texture2D;
@export var value: float = 0.0;
@export var max_stacks: int = 10;
@export var rarity: POWERUP_RARITY = POWERUP_RARITY.COMMON;
@export var type: POWERUP_TYPE;
@export var modifier_type : MODIFIER_TYPE = MODIFIER_TYPE.FLAT_INCREASE;

func getValue() -> float:
	var current_value = value;
	if(!self.is_percentage()): 
		return current_value;
		
	return current_value / 100.0;

static func getPowerupKey(_type: POWERUP_TYPE, _is_percentage: bool) -> String:
	return "{type}_{is_percentage}".format({"type": POWERUP_TYPE_TO_STRING[_type], "is_percentage": _is_percentage })
	
func is_percentage() -> bool:
	return modifier_type in [MODIFIER_TYPE.PERCENTAGE_INCREASE, MODIFIER_TYPE.PERCENTAGE_DECREASE]

func is_increase() -> bool:
	return modifier_type in [MODIFIER_TYPE.FLAT_INCREASE, MODIFIER_TYPE.PERCENTAGE_INCREASE]
	
func to_pretty():
	return {display_name = display_name, value = self.getValue(), type = POWERUP_TYPE_TO_STRING[type], is_percentage = is_percentage}

enum MODIFIER_TYPE {
	FLAT_INCREASE,      # +10
	FLAT_DECREASE,      # -10
	PERCENTAGE_INCREASE,  # +10%
	PERCENTAGE_DECREASE   # -10%
}

enum POWERUP_RARITY {
	LEGENDARY,
	EPIC,
	RARE,
	UNCOMMON,
	COMMON
}

const POWERUP_RARITY_TO_STRING = {
	POWERUP_RARITY.COMMON: "COMMON",
	POWERUP_RARITY.UNCOMMON: "UNCOMMON",
	POWERUP_RARITY.RARE: "RARE",
	POWERUP_RARITY.EPIC: "EPIC",
	POWERUP_RARITY.LEGENDARY: "LEGENDARY"
}

const POWERUP_TYPE_TO_STRING = {
	POWERUP_TYPE.TOWER_ATTACK_SPEED: "TOWER_ATTACK_SPEED",
	POWERUP_TYPE.TOWER_ATTACK_DAMAGE: "TOWER_ATTACK_DAMAGE",
	POWERUP_TYPE.UNIT_HEALTH: "UNIT_HEALTH",
	POWERUP_TYPE.UNIT_ATTACK_DAMAGE: "UNIT_ATTACK_DAMAGE",
	POWERUP_TYPE.ENEMY_XP_DROP: "ENEMY_XP_DROP",
	POWERUP_TYPE.ENEMY_GOLD_DROP: "ENEMY_GOLD_DROP",
	POWERUP_TYPE.BUILDING_DISCOUNT: "BUILDING_DISCOUNT"
}

enum POWERUP_TYPE {
	TOWER_ATTACK_SPEED,
	TOWER_ATTACK_DAMAGE,
	UNIT_HEALTH,
	UNIT_ATTACK_DAMAGE,
	ENEMY_XP_DROP,
	ENEMY_GOLD_DROP,
	BUILDING_DISCOUNT
}
