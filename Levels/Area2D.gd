extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().paused = true
		get_node("AnimatedSprite2D").play("Idle")
		get_node("Shop/Anim").play("TransIn")


func _to_checkbody_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../PlayerChecker/Sprite2D".visible = true
		$"../PlayerChecker/Caution".visible = true
	
func _to_checkbody_exited(body: Node2D) -> void:
	if body.name == "Player":
		await get_tree().create_timer(0.85).timeout
		$"../PlayerChecker/Sprite2D".visible = false
		$"../PlayerChecker/Caution".visible = false
