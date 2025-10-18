class_name EnemySpawnerComponent
extends Node2D

@export var spawnerQueue : Array[SpawnerEntity];
@export var spawnGoalNode: Node2D;
@export var parentNode: Node2D;

@export_range(0.1, 10) var spawnTimeout: float; 
@onready var timer: Timer = $Timer

var currentSpawnerQueue: Array[SpawnerEntity];

signal onEntitySpawn(entity: PackedScene);
signal onSpawnQueueCompleted;

func _ready() -> void:
	timer.wait_time = spawnTimeout;
	timer.autostart = true; # must change
	currentSpawnerQueue = spawnerQueue.duplicate_deep();

func _on_timer_timeout() -> void:
	if(currentSpawnerQueue.is_empty()):
		timer.stop();
		onSpawnQueueCompleted.emit();
		return;
		
	var spawnResource = currentSpawnerQueue[0]
	spawnResource.count -= 1;
	if(spawnResource.count <= 0):
		currentSpawnerQueue.pop_front()
	
	_spawn_entity(spawnResource.entity)
	
func _spawn_entity(entity: PackedScene):
	var spawnedEntity = entity.instantiate() as Enemy;
	spawnedEntity.position = self.position;
	spawnedEntity.navigation_target = spawnGoalNode;
	# need to set enemy.target node
	if(parentNode != null):
		parentNode.add_child(spawnedEntity);
		
	onEntitySpawn.emit(entity);
