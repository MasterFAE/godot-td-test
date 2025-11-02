extends Node

@export var income_range : Vector2i;
@export_range(0.1, 300) var income_cooldown: float;

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.wait_time = income_cooldown;
	timer.autostart = true;

func _on_timer_timeout() -> void:
	var coin = randi_range(income_range[0], income_range[1]);
	CurrencyManager.collectCoin(coin); # Replace with function body.
