class_name HealthComponent
extends Node

@export_range(1.0, 5000) var maxHealth : float = 20;

signal onHealthChange;
signal onDeath;

var _currentHealth;

func _ready() -> void:
	_currentHealth = maxHealth;

func dealDamage(damage: float) -> void:
	print(get_parent().name, " damage received: " , damage)
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
	_currentHealth = clampf(health, 0, maxHealth);
	onHealthChange.emit(_currentHealth);

func setInitialHealth(_maxHealth: float) -> void:
	if(_maxHealth <= 0):
		printerr(str(_maxHealth), " health set initially by ", get_parent().name)
		_maxHealth = 1;
	self.maxHealth = _maxHealth;
	self._currentHealth = _maxHealth;
