extends Node2D

@export var navigation_target: Node2D;
@export var parent_node: Node;
@export var spawnerLevelQueue : Array[SpawnerEntityQueue];
@onready var enemy_spawner_component: SpawnerComponent = $SpawnerComponent

var currentWave = 0;

func _ready() -> void:
	enemy_spawner_component._setup_spawner(self.spawnerLevelQueue[0].entity_queue, self.position, parent_node)
	GameSignalBus.onStartNewWave.connect(onStartNewWave);
	
	
func _on_spawner_component_on_entity_spawn(entity: Node) -> void:
	var enemyEntity = entity as Enemy
	if(enemyEntity == null):
		return;
	enemyEntity.path_finding_component.setTargetLocation(navigation_target)


func _on_spawner_component_on_spawn_queue_completed() -> void:
	print("Wave completed")
	GameSignalBus.onCompleteWave.emit();


func onStartNewWave(wave: int):
	currentWave = wave;
	enemy_spawner_component._update_queue(spawnerLevelQueue[wave].entity_queue);
	if(enemy_spawner_component.timer.is_stopped()):
		enemy_spawner_component.timer.start();
