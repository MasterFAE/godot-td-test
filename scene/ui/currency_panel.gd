extends Control

@onready var coin_label: Label = $"PanelContainer/MarginContainer/HBoxContainer/Coin Label"
@onready var level_label: Label = $ExpContainer/Level
@onready var exp_bar: ProgressBar = $ExpContainer/ExpBar

func _ready() -> void:
	onCoinChange(CurrencyManager.current_coin)
	onLevelUp(ExperienceManager.current_level);
	CurrencyManager.onCoinChange.connect(onCoinChange)
	ExperienceManager.onLevelUp.connect(onLevelUp)
	ExperienceManager.onExpChange.connect(onExpChange)

func onCoinChange(coin: int) -> void:
	coin_label.text = str(coin)

func onLevelUp(level: int) -> void:
	level_label.text = "Lv. {level}".format({"level": str(level)});
	exp_bar.max_value = ExperienceManager.getRequiredExperienceForLevelup();

func onExpChange(xp: float) -> void:
	exp_bar.value = xp;
