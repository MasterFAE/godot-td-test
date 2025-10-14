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
	self.label.text = tower_variant.tower_name;
	self.range_value.text = "Long";
	CurrencyManager.onCoinChange.connect(_monitor_coin)
	
func _monitor_coin(_current_coin: int) -> void:
	self.disabled = !CurrencyManager.canAfford(tower_variant.build_cost);

func _on_pressed() -> void:
	UiSignalBus.onTriggerNewBuild.emit(tower_scene, tower_variant.build_cost)
