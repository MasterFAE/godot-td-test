class_name PathfindingComponent;
extends Node2D

@export var navigation_target: Node2D;
@export var character_body: CharacterBody2D;
@export var velocity_component: VelocityComponent;

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D

var isMoving := true;

signal onNavigationTargetReached;

func _ready() -> void:
	if(navigation_target != null):
		self.setTargetLocation(navigation_target);

func setTargetLocation(target: Node2D):
	print("test???")
	print_debug(target, navigation_agent_2d)
	navigation_agent_2d.target_position = target.global_position;
	# might require to recalculate path.

func _physics_process(_delta: float) -> void:
	if(navigation_agent_2d.target_position == null):
		return;
	
	if(!navigation_agent_2d.is_target_reached()):
		var _target = navigation_agent_2d.get_next_path_position() - character_body.global_position		
		velocity_component.moveToDirection(_target);
	else:
		navigation_target_reached();
		
func navigation_target_reached():
	onNavigationTargetReached.emit()
