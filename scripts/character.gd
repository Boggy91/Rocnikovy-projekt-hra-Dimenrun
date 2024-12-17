extends CharacterBody2D

var SPEED = 200.0
const JUMP_VELOCITY = -400.0

const DASH = 600.0
var dashing = false
var can_dash = true
var is_hit = false

var jump_count = 0
var max_jump = 2

var is_wall_sliding = false
var wall_jump_direction = 0
var last_wall_side = 0  # Tracks which wall was last jumped from (-1 for left, 1 for right)

var is_godmode = false  # Godmode toggle

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func jump():
	velocity.y = JUMP_VELOCITY

func hit(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _physics_process(delta: float) -> void:
	# Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Toggle godmode
	if Input.is_action_just_pressed("godmode"):
		is_godmode = !is_godmode  # Switch godmode state
		if is_godmode:
			print("Godmode activated")
		else:
			print("Godmode deactivated")
			SPEED = 200
		velocity = Vector2.ZERO  # Reset velocity when toggling godmode
	
	# Godmode logic
	if is_godmode:
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
		
		velocity = god_direction.normalized() * SPEED
		move_and_slide()
		return  # Skip other physics when in godmode
	
	# Add gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0:
			sprite_2d.animation = "jumping"
		else:
			sprite_2d.animation = "falling"
	else:
		jump_count = 0
		is_wall_sliding = false
		last_wall_side = 0

	# Wall sliding
	if not is_on_floor() and is_on_wall():
		var direction := Input.get_axis("left", "right")
		if direction != 0:
			is_wall_sliding = true
			velocity.y = min(velocity.y, 100)  # Slow down the fall when sliding
			sprite_2d.animation = "wall_slide"
			if direction < 0:
				wall_jump_direction = 1
				sprite_2d.flip_h = true  # Flip sprite to face right when sliding on the left wall
			else:
				wall_jump_direction = -1
				sprite_2d.flip_h = false  # Flip sprite to face left when sliding on the right wall

	# Handle wall jump
	if Input.is_action_just_pressed("jump") and is_wall_sliding:
		if wall_jump_direction != last_wall_side:
			velocity.y = JUMP_VELOCITY
			velocity.x = wall_jump_direction * SPEED
			is_wall_sliding = false
			last_wall_side = wall_jump_direction
			return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < max_jump and not is_wall_sliding:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	# Dashing
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing = true
		can_dash = false
		$Timers/dash_timer.start()
		$Timers/dash_again_timer.start()
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		if is_on_wall():
			wall_jump_direction = -sign(direction)  # Opposite direction of the wall
		if dashing:
			velocity.x = direction * DASH
			sprite_2d.animation = "dash"
		else:
			velocity.x = direction * SPEED
		# Flip sprite based on movement direction when not wall sliding
		if not is_wall_sliding:
			sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
	
	# Reset
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	dashing = false

func _on_dash_again_timer_timeout() -> void:
	can_dash = true

func _on_hit_timer_timeout() -> void:
	is_hit = false
