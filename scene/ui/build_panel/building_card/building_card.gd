extends TextureButton

@onready var texture_rect: TextureRect = $MarginContainer/VBoxContainer/TextureRect
@onready var label: Label = $MarginContainer/VBoxContainer/Label
@onready var attack_value: Label = $MarginContainer/VBoxContainer/HBoxContainer/DamageContainer/Value
@onready var range_value: Label = $MarginContainer/VBoxContainer/HBoxContainer/RangeContainer/Value

@export var tower_scene: PackedScene;
@export var tower_variant: TowerVariation;

func _ready() -> void:
	#texture_rect.texture = 
	self.attack_value.text = str(tower_variant.attack_stats.attack_damage);
	self.label.text = "{name} {cost}".format({"name": tower_variant.tower_name, "cost": tower_variant.build_cost});
	self.range_value.text = "Long";
	CurrencyManager.onCoinChange.connect(_monitor_coin)
	PowerupManager.onPowerUpAdded.connect(_monitor_powerup)
	
func _monitor_coin(_current_coin: int) -> void:
	self.disabled = !CurrencyManager.canAfford(tower_variant.build_cost);
	
func _monitor_powerup(powerup: PowerUp) -> void:
	if(powerup.type != PowerUp.POWERUP_TYPE.BUILDING_DISCOUNT):
		return;
	var cost = PowerupManager.get_powered_stat_by_powerup(tower_variant.build_cost, powerup);
	self.label.text = "{name} {cost}".format({"name": tower_variant.tower_name, "cost": cost});
	_monitor_coin(CurrencyManager.current_coin);

func _on_pressed() -> void:
	UiSignalBus.onTriggerNewBuild.emit(tower_scene, tower_variant.build_cost)
