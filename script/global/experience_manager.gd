extends Node

const REQUIRED_EXP_MULTIPLIER : float = 1.2;
const MIN_REQUIRED_EXP : float = 100;

var current_level : int = 1;
var current_exp: float = 0;
signal onLevelUp(level: int);
signal onExpChange(xp: float);

func addExperience(xp: float):
	var required_exp = self.getRequiredExperienceForLevelup()
	var new_exp = current_exp + xp;
	if(new_exp < required_exp):
		current_exp = new_exp;
	else:
		var additional_exp = new_exp - required_exp;
		current_level += 1;
		onLevelUp.emit(current_level)
		current_exp = additional_exp;
	onExpChange.emit(current_exp);
	
func getRequiredExperienceForLevelup() -> float:
	return MIN_REQUIRED_EXP * pow(REQUIRED_EXP_MULTIPLIER, current_level-1);
