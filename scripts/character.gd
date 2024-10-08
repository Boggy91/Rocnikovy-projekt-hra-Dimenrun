extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0

const DASH = 600.0
var dashing = false
var can_dash = true

var jump_count = 0
var max_jump = 2

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func jump():
	velocity.y = JUMP_VELOCITY

func hit(x):
	velocity.y= -200.0
	velocity.x = x
	

func _physics_process(delta: float) -> void:
	#Animations
	if (velocity.x>1|| velocity.x<-1):
		sprite_2d.animation="running"
	else:
		sprite_2d.animation="default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if (velocity.y<0):
			sprite_2d.animation="jumping"
		else:
				sprite_2d.animation="falling"
			
	if is_on_floor():
		jump_count= 0
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < max_jump:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	# Dashing
	if Input.is_action_just_pressed("dash") and can_dash:
		dashing=true
		can_dash= false
		$Timers/dash_timer.start()	
		$Timers/dash_again_timer.start()
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		if dashing:
			velocity.x = direction * DASH
			sprite_2d.animation="dash"
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 12)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft


func _on_timer_timeout() -> void:
	dashing=false


func _on_dash_again_timer_timeout() -> void:
	can_dash= true
