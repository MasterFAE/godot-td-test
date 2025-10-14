extends Node

@export var building_tilemap : TileMapLayer;
@export var mouse_tracker: MouseTracker;

var buildTiles : Array[Vector2i] = [];

var isBuilding : bool = false
var tempBuilding: PackedScene;
var tempBuildingCost: int;


func _ready() -> void:
	UiSignalBus.onTriggerNewBuild.connect(_new_tower_building);
	UiSignalBus.onCancelNewBuild.connect(_reset_temp_building);

func _new_tower_building(tower: PackedScene, cost: int):
	print("new building")
	tempBuildingCost = cost;
	tempBuilding = tower;
	isBuilding = true;
	
	
func _reset_temp_building():
	isBuilding = false;
	tempBuilding = null;
	tempBuildingCost = 0;

func _input(event: InputEvent) -> void:
	if(isBuilding && event.is_action_pressed("mouse_left") && _check_is_buildable()):
		buildTiles.append(mouse_tracker.currentCell);
		CurrencyManager.spendCoin(tempBuildingCost);
		var newBuild = tempBuilding.instantiate();
		add_child(newBuild);
		newBuild.position = mouse_tracker.currentCell * mouse_tracker.TILE_SIZE;
		_reset_temp_building();
		
	elif(isBuilding && event.is_action_released("mouse_right")):
		UiSignalBus.onCancelNewBuild.emit();
		

func _check_is_buildable() -> bool:
	if(!CurrencyManager.canAfford(tempBuildingCost)):
		return false;
	
	var clicked_cell = building_tilemap.local_to_map(building_tilemap.get_local_mouse_position())
	var data = building_tilemap.get_cell_tile_data(clicked_cell)
	
	if(data == null): 
		return false
		
	if(!data.get_custom_data("buildable")):
		return false;
		
	if(buildTiles.has(mouse_tracker.currentCell)):
		return false;
		
	return true;
