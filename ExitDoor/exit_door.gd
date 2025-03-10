extends Node2D

@export var needs_key: bool = false
@export var next_scene: String

func _on_door_open_animate_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	$ClosedDoor.hide()
	$OpenDoor.show()


func _on_door_open_animate_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	$ClosedDoor.show()
	$OpenDoor.hide()


func _on_go_to_next_scene_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
	if needs_key:
		if body.has_key:
			Globals.last_level = next_scene
			Globals.save_game()
			get_tree().change_scene_to_file(next_scene)
	else:
		Globals.last_level = next_scene
		Globals.save_game()
		get_tree().change_scene_to_file(next_scene)
