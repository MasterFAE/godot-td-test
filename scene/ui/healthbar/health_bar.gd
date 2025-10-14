extends TextureProgressBar


@export var health_component: HealthComponent
	
func _ready() -> void:
	health_component.onHealthChange.connect(onHealthChange)
	value = health_component.getHealthPercentage();
	
func onHealthChange(_health: float) -> void:
	value =health_component.getHealthPercentage();
