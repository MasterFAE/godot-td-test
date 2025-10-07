class_name HealthComponent
extends Node

@export_range(1.0, 5000) var maxHealth : float = 20;

signal onHealthChange;
signal onDeath;

var _currentHealth;

func _ready() -> void:
	_currentHealth = maxHealth;

func dealDamage(damage: float) -> void:
	setHealth(self.getCurrentHealth() - damage)
	if(self.isDead()):
		onDeath.emit();

func healDamage(heal: float) -> void:
	setHealth(self.getCurrentHealth() + heal)
	
func getCurrentHealth() -> float:
	return _currentHealth;
	
func isDead() -> bool:
	return self.getCurrentHealth() <= 0;
	
func setHealth(health: float):
	_currentHealth = clampf(health, 0, health);
	onHealthChange.emit(_currentHealth);
