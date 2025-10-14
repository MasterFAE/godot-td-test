extends Control

@onready var building_panel_container: HBoxContainer = $BuildingsHbox

func _on_button_pressed() -> void:
	if(building_panel_container.visible):
		building_panel_container.hide()
	else:
		building_panel_container.show()
