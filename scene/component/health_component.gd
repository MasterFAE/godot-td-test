class_name HealthComponent
extends Node

@export var maxHealth : float;

signal onHealthChange;

var _currentHealth;

func dealDamage(damage: float) -> void:
	setHealth(self.getCurrentHealth() - damage)

func healDamage(heal: float) -> void:
	setHealth(self.getCurrentHealth() + heal)
	
func getCurrentHealth() -> float:
	return _currentHealth;
	
func isDead() -> bool:
	return self.getCurrentHealth() <= 0;
	
func setHealth(health: float):
	_currentHealth = clampf(health, 0, health);
	onHealthChange.emit(_currentHealth);
