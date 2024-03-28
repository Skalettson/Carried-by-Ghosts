extends CanvasLayer

var SCROLL_SPEED_H := 70

func _ready() -> void:
	if Globals.last_level == "":
		$MarginContainer/VBoxContainer/ContinueGame.visible = false
	else:
		$MarginContainer/VBoxContainer/ContinueGame.visible = true

func _on_start_game_pressed() -> void:
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = Globals.collects_n_h
	Globals.last_level = ""
	Globals.save_game()
	get_tree().change_scene_to_file("res://Levels/level1.tscn")

func _on_continue_game_pressed() -> void:
	GlobalVars.score = 0
	if not GlobalVars.hi_score:
		GlobalVars.hi_score = Globals.collects_n_h
	Globals.load_game()
	get_tree().change_scene_to_file(Globals.last_level)

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_hi_score_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/hall_of_fame.tscn")

func _process(delta: float) -> void:
	$ParallaxBackground.scroll_offset.x += SCROLL_SPEED_H * delta
	pass

func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://res/Menu/options.tscn")
