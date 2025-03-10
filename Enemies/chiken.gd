extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
var direction := -1
var spawn_position : Vector2

const SPEED = 30.0
const JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	velocity = Vector2.ZERO
	spawn_position = position
	if randf() < 0.5:
		direction = -1
	else:
		direction = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_wall():
		direction = -direction

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	update_animation()
	if position.y > 480:
		on_death()

func update_animation():
	if velocity.x < 0:
		anim.flip_h = false
	elif velocity.x > 0:
		anim.flip_h = true
	if velocity.x:
		anim.play("Run")
	else:
		anim.play("Idle")

func on_death():
	position = spawn_position
	#queue_free()
