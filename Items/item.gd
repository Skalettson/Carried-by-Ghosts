extends Area2D

enum item_type {ITEM_FRUIT, ITEM_KEY, ITEM_D_JUMP, ITEM_BONUS}
@export var type : item_type

@export var points : int = 1
var is_picked : bool = false
@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	pass

func on_pickup(body):
	if is_picked:
		return
	is_picked = true
	anim.play("Collected")
	await get_tree().create_timer(0.25).timeout
	var tween1 = get_tree().create_tween().set_parallel(true)
	tween1.tween_property($".", "position:y", position.y - 20, 0.6)
	tween1.tween_property($AnimatedSprite2D, "self_modulate:a", 0.0, 0.8)
	
	GlobalVars.score += points
	Globals.collects_n_h = GlobalVars.hi_score
	if (GlobalVars.score > GlobalVars.hi_score):
		GlobalVars.hi_score = GlobalVars.score
		$OnRecord.play()
		await $OnRecord.finished
	else:
		$Sound.play()
		await $Sound.finished
	await tween1.finished
	
	match type:
		item_type.ITEM_FRUIT:
			pass
		item_type.ITEM_KEY:
			body.has_key = true
		item_type.ITEM_BONUS:
			pass
		item_type.ITEM_D_JUMP:
			body.has_double_jump = true
	
	queue_free()
