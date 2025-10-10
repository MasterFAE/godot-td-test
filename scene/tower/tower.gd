extends StaticBody2D

@export var tower_variant: TowerVariation;
@export var tower_projectile: PackedScene;
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var projectiles: Node = $Projectiles
@onready var attack_component: AttackComponent = $AttackComponent

func _ready() -> void:
	attack_component.setAttackCooldown(tower_variant.attack_cooldown);
	attack_component.onAttacked.connect(_fire_projectile)
	#range_collider.shape.radius = tower_variant.attack_range * 64;
	
func _fire_projectile(enemy: CharacterBody2D) -> void:
	var _projectile = tower_projectile.instantiate() as Projectile;
	_projectile.target = enemy;
	_projectile.damage = tower_variant._calculate_damage();
	_projectile.global_position = Vector2(global_position.x, global_position.y - 15);
	projectiles.add_child(_projectile);
