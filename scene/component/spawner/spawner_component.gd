class_name SpawnerComponent
extends Node

@export var spawnPosition : Vector2;
@export var spawnerQueue : Array[SpawnerEntity];
@export var parentNode: Node2D;

@export_range(0.1, 10) var spawnTimeout: float; 
@onready var timer: Timer = $Timer

var currentSpawnerQueue: Array[SpawnerEntity];

signal onEntitySpawn(entity: Node);
signal onSpawnQueueCompleted;

func _setup_spawner(queue: Array[SpawnerEntity], _spawnPosition: Vector2, _parentNode: Node2D, timeout: float = 1.0):
	self._update_queue(queue);	
	self.spawnPosition = _spawnPosition;
	self.parentNode = _parentNode;
	self.timer.wait_time = timeout;

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
	spawnedEntity.position = spawnPosition;
	# need to set enemy.target node
	if(parentNode != null):
		parentNode.add_child(spawnedEntity);
		
	onEntitySpawn.emit(spawnedEntity);
	
func _update_queue(queue: Array[SpawnerEntity]):
	self.spawnerQueue = queue;
	self.currentSpawnerQueue = queue.duplicate_deep();
