extends CharacterBody2D

@onready var game_manager: Node = %"game manager"

var speed = -60
var facing_right=false
var killed= false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()



	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x)*-1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed)* -1


	
