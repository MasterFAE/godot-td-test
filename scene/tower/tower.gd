extends StaticBody2D

@export var tower_variant: TowerVariation;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var range_collider: CollisionShape2D = $Range/RangeCollider
@onready var attack_timer: Timer = $"Attack Timer"
@onready var projectiles: Node = $Projectiles

var projectile := preload("uid://cco748i655w52");

var enemies_in_range : Array[Enemy] = [];

func _ready() -> void:
	sprite_2d.texture = tower_variant.texture;
	range_collider.shape.radius = tower_variant.attack_range * 64;
	attack_timer.wait_time = tower_variant.attack_cooldown;
	attack_timer.autostart = true;
	
func _on_attack_timer_timeout() -> void:
	if(enemies_in_range.is_empty()):
		attack_timer.paused = true;
		return;
		
	var current_enemy = enemies_in_range[0];
	print_debug(current_enemy)
	if(current_enemy):
		self._fire_projectile(current_enemy);
	
func _fire_projectile(enemy: Enemy) -> void:
	var _projectile = projectile.instantiate() as Projectile;
	_projectile.projectile_variation = tower_variant.projectile_variation;
	_projectile.target = enemy;
	_projectile.damage = self._calculate_damage();
	_projectile.global_position = Vector2(global_position.x, global_position.y - 15);
	projectiles.add_child(_projectile);
	
func _calculate_damage() -> float:
	var damage = tower_variant.attack_damage;
	var crit_random_rate = randf();
	if(tower_variant.crit_rate <= crit_random_rate):
		damage *= tower_variant.crit_multiplier;
	return damage;

func _on_range_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		print_debug("Enemy entered field", body.name)
		attack_timer.paused = false;
		enemies_in_range.push_back(body);
		

func _on_range_body_exited(body: Node2D) -> void:
	if(body is Enemy):
		print_debug("Enemy left the field", body.name)
		enemies_in_range.pop_front();
