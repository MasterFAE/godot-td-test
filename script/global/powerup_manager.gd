extends Node

var current_powerups : Dictionary = {};
signal onPowerUpAdded(powerup: PowerUp);

func add_powerup(powerup: PowerUp) -> void:
	var powerup_key = PowerUp.getPowerupKey(powerup.type, powerup.is_percentage());
	if(powerup_key not in current_powerups):
		current_powerups[powerup_key] = 0
	Log.pr(powerup);
	current_powerups[powerup_key] += powerup.getValue();
	onPowerUpAdded.emit(powerup);
	
func get_powered_stat_by_powerup(input: float, powerup: PowerUp) -> float:
	return self.get_powered_stat(input, powerup.type, powerup.is_increase());
	
	
func get_powered_stat(input: float, powerup_type: PowerUp.POWERUP_TYPE, is_increase: bool) -> float:
	var percentage_powerup_key = PowerUp.getPowerupKey(powerup_type, true);
	var percentage_powerup = 0;
	if(percentage_powerup_key in current_powerups):
		percentage_powerup = current_powerups[percentage_powerup_key];
	
	var value_powerup_key = PowerUp.getPowerupKey(powerup_type, false);
	var value_powerup = 0;
	if(value_powerup_key in current_powerups):
		value_powerup = current_powerups[value_powerup_key]
	
	var output = input;
	if(is_increase):
		output = input * (1 + percentage_powerup) + value_powerup;
	else:
		output = input * (1 - percentage_powerup) - value_powerup;
	Log.pr({"type": PowerUp.POWERUP_TYPE_TO_STRING[powerup_type], "input": input, "output": output, "value": value_powerup, "perc": percentage_powerup})
	return clampf(output, 0.1, output);
