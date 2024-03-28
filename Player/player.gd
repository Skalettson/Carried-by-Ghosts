extends CharacterBody2D

var tilemap_for_camera : TileMap

const SPEED = 210.0
const JUMP_VELOCITY = -300.0
const  WALL_JUMP_PUSHBACK = 300
const WALL_SLIDE_GRAVITY = 50
var is_wall_sliding: bool = false
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var cam = $Camera2D as Camera2D
var has_key : bool = false
var has_double_jump : bool = false
var can_double_jump : bool = false
var dashDirection = Vector2.ZERO
var is_dashing : bool = false
var canDash : bool = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var screenSize = get_viewport_rect().size
var tolerance = 10

func _ready() -> void:
	GlobalVars.score
	tilemap_for_camera = get_parent().find_child("TileMap")
	var r = tilemap_for_camera.get_used_rect()
	var vp = tilemap_for_camera.get_viewport_rect()
	var qs = tilemap_for_camera.cell_quadrant_size
	cam.limit_left = r.position.x * qs
	cam.limit_top = r.position.y * qs
	cam.limit_right = r.end.x * qs
	cam.limit_bottom = r.end.y * qs
	cam.limit_top = min(r.position.y, r.end.y - vp.size.y)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("pl_accept"):
		if is_on_floor():
			can_double_jump = true
			velocity.y = JUMP_VELOCITY
		if not is_on_floor() and has_double_jump and can_double_jump:
			can_double_jump = false
			velocity.y = JUMP_VELOCITY * 0.95
		if is_on_wall() and Input.is_action_pressed("pl_right"):
			velocity.y = JUMP_VELOCITY
			velocity.x = -WALL_JUMP_PUSHBACK
		if is_on_wall() and Input.is_action_pressed("pl_left"):
			velocity.y = JUMP_VELOCITY
			velocity.x = WALL_JUMP_PUSHBACK

	var direction = Input.get_axis("pl_left", "pl_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation()
	player_dash()
	move_and_slide()
	wall_slide(delta)
	if position.y > screenSize.y + tolerance:
		on_death()
	if position.y < $Camera2D.limit_top + 0:
		position.y = $Camera2D.limit_top + 0

func update_animation():
	if velocity.x < 0:
		anim.flip_h = true
		dashDirection = Vector2(-1, 0)
	elif velocity.x > 0:
		anim.flip_h = false
		dashDirection = Vector2(1, 0)
	if velocity.x:
		anim.play("Run")
	else:
		anim.play("Idle")
	if velocity.y < 0:
		anim.play("Jump")
	elif velocity.y > 0:
		anim.play("Fall")

func on_death():
	Globals.deaths_n += 1
	get_tree().change_scene_to_file("res://Menus/game_over.tscn")
	queue_free()


func _on_pickup_area_entered(area: Area2D) -> void:
	if area.has_method("on_pickup"):
		area.on_pickup(self)

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("pl_left") or Input.is_action_pressed("pl_right"):
			is_wall_sliding = true
			anim.play("WallSlide")
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	if is_wall_sliding:
		velocity.y += (WALL_SLIDE_GRAVITY * delta)
		velocity.y = min(velocity.y, WALL_SLIDE_GRAVITY)

func player_dash():
	if GlobalVars.player_dashfunc == true:
		$MobileControl/DashBut.visible = true
		
		if Input.is_action_just_pressed("pl_dash") and canDash:
			velocity = dashDirection.normalized() * 1700
			canDash = false
			is_dashing = true
			anim.play("Hit")
			await get_tree().create_timer(0.45).timeout
			is_dashing = false
			canDash = true
