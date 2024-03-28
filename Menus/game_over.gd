extends CanvasLayer

func _on_you_died_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
