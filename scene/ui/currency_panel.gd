extends Control

@onready var coin_label: Label = $"PanelContainer/MarginContainer/HBoxContainer/Coin Label"

func _ready() -> void:
	coin_label.text = str(CurrencyManager.current_coin);
	CurrencyManager.onCoinChange.connect(onCoinChange)


func onCoinChange(coin: int) -> void:
	coin_label.text = str(coin)
