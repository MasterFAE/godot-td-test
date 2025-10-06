class_name Enemy 
extends CharacterBody2D

@export var stats : EnemyStats;
@onready var health_component: HealthComponent = $HealthComponent
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@export var navigation_target: Node2D;


func _ready() -> void:
	health_component.maxHealth = stats.max_health;
	health_component.setHealth(stats.max_health);
	health_component.onHealthChange.connect(_is_dead)
	sprite_2d.texture = stats.character_texture;
	navigation_agent_2d.target_position = navigation_target.global_position;

func _physics_process(_delta: float) -> void:
	if(!navigation_agent_2d.is_target_reached()):
		velocity = navigation_agent_2d.get_next_path_position() - global_position		
		if abs(velocity.x) > abs(velocity.y):
			velocity.y = 0
		else:
			velocity.x = 0
			
		velocity = velocity.normalized() *  stats.movement_speed;
		move_and_slide();
	else:
		navigation_target_reached();
		
func navigation_target_reached():
	# reduce player health;
	self.queue_free();
	pass;

func _is_dead(currentHealth: float) -> void:
	if(currentHealth <= 0):
		self.queue_free(); 
	
func _on_projectile_area_body_entered(body: Node2D) -> void:
	if(body is not Projectile):
		return;
		
	var projectile = body as Projectile;
	print_debug("Projectile entered:", projectile.name);
	health_component.dealDamage(projectile.damage)
	projectile.queue_free();
