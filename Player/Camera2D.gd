extends Camera2D

var level

func _ready() -> void:
	level = get_parent().get_node_and_resource("LevelBase")
	offset = level.global_position

func _process(delta: float) -> void:
	global_position = level.global_position - offset
