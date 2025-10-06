class_name ProjectileVariation
extends Resource

@export var projectile_texture: Texture2D;
@export_range(100, 100000) var projectile_speed := 500.0;
#@export_range(1, 10) var projectile_collider_size;
#@export var hit_effects : HitEffect;
