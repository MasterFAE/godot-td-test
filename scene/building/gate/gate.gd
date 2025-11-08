extends CharacterBody2D

@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_component: HurtComponent = $HurtComponent

func _ready() -> void:
	hurt_component.onHurt.connect(health_component.dealDamage);
	health_component.onDeath.connect(onDeath);


func onDeath() -> void:
	self.queue_free()
