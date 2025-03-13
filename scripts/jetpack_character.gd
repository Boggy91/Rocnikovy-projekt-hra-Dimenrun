extends CharacterBody2D

var SPEED = 200.0
const JUMP_VELOCITY = -400.0
const JETPACK_FORCE = -500.0  # Adjust for smoother flight
const MAX_FALL_SPEED = 500.0  # Limits downward speed
const MAX_JETPACK_SPEED = -300.0  # Maximum upward speed

var is_hit = false
var is_godmode = false  # Godmode toggle

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var hit_timer: Timer = $Timers/hit_timer
@onready var sfx_jump: AudioStreamPlayer = $SFX_jump
@onready var sfx_hit: AudioStreamPlayer = $SFX_hit

func jump():
	velocity.y = JUMP_VELOCITY
	'sfx_jump.play()'

func _on_hit_timer_timeout() -> void:
	is_hit = false

func _physics_process(delta: float) -> void:
	if is_hit:
		return

	# Handle animations
	if is_godmode:
		handle_godmode_movement()
		return

	handle_movement(delta)
	handle_gravity(delta)
	handle_animations()

	move_and_slide()

	# Reset
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		Global.reset_points()

func handle_movement(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		if Input.is_action_pressed("jump"):  # Jetpack mode
			velocity.y += JETPACK_FORCE * delta
			velocity.y = max(velocity.y, MAX_JETPACK_SPEED)  # Limit max jetpack speed
		else:
			velocity += get_gravity() * delta

		velocity.y = min(velocity.y, MAX_FALL_SPEED)  # Limit falling speed
	else:
		if Input.is_action_just_pressed("jump"):
			jump()

func handle_animations() -> void:
	if not is_on_floor():
		if Input.is_action_pressed("jump"):
			sprite_2d.animation = "falling on"
		else:
			sprite_2d.animation = "falling off"
		if velocity.y < 0:
			sprite_2d.animation = "jumping"
	else:
		if abs(velocity.x) > 1:
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "default"

func handle_godmode_movement() -> void:
	var god_direction = Vector2.ZERO
	if Input.is_action_pressed("up"):
		god_direction.y -= 1
	if Input.is_action_pressed("down"):
		god_direction.y += 1
	if Input.is_action_pressed("left"):
		god_direction.x -= 1
	if Input.is_action_pressed("right"):
		god_direction.x += 1

	SPEED = 500
	sprite_2d.animation = "default"
	velocity = god_direction.normalized() * SPEED
	move_and_slide()
	set_collision_mask_value(1, false)
