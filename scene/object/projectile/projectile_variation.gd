class_name ProjectileVariation
extends Resource

@export var projectile_texture: Texture2D;
@export_range(0.1, 100) var projectile_speed;
@export_range(1, 10) var projectile_collider_size;
#@export var hit_effects : HitEffect;
