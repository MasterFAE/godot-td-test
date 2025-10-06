class_name Enemy 
extends CharacterBody2D

@export var stats : EnemyStats;
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	health_component.maxHealth = stats.max_health;
	health_component.setHealth(stats.max_health);
	health_component.onHealthChange.connect(_is_dead)
	sprite_2d.texture = stats.character_texture;
	

func _is_dead(currentHealth: float) -> void:
	if(currentHealth <= 0):
		self.queue_free(); 
	
func _on_projectile_area_body_entered(body: Node2D) -> void:
	if(body is not Projectile):
		return;
		
	var projectile = body as Projectile;
	health_component.dealDamage(projectile.damage)
	body.queue_free();
