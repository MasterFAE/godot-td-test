extends Node

var current_powerups : Dictionary = {};
signal onPowerUpAdded(powerup: PowerUp);

func add_powerup(powerup: PowerUp) -> void:
	var powerup_key = PowerUp.getPowerupKey(powerup.type, powerup.is_percentage);
	if(powerup_key not in current_powerups):
		current_powerups[powerup_key] = 0
	Log.pr(powerup);
	current_powerups[powerup_key] += powerup.getValue();
	onPowerUpAdded.emit(powerup);
	
func get_powered_stat(input: float, powerup_type: PowerUp.POWERUP_TYPE, is_multiplier: bool) -> float:
	var percentage_powerup_key = PowerUp.getPowerupKey(powerup_type, true);
	var percentage_powerup = 1; # to avoid division by zero
	if(percentage_powerup_key in current_powerups):
		percentage_powerup = current_powerups[percentage_powerup_key];
	
	var value_powerup_key = PowerUp.getPowerupKey(powerup_type, false);
	var value_powerup = 0;
	if(value_powerup_key in current_powerups):
		value_powerup = current_powerups[value_powerup_key]
		
	var output = input;
	if(is_multiplier):
		output = input * percentage_powerup + value_powerup;
	else:
		output = input / percentage_powerup + value_powerup;
	Log.pr("input: ", input, "output: ", output)
	return output;
