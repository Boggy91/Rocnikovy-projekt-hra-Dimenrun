extends CharacterBody2D

@onready var game_manager: Node = %"game manager"
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


var speed = -60
var facing_right=false
var killed = false

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
	

func _on_hitbox_body_entered(body):
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print(y_delta)
		if (y_delta > 20):
			print("Destroy enemy")
			killed= true
			if killed:
				animated_sprite_2d.animation="killed"
				$killed_timer.start()
				body.jump()
		else:
			print("Decrease player health")
			game_manager.decrease_health()
			if(x_delta>0):
				body.hit(300)
			else:
				body.hit(-300)
		
func _on_killed_timer_timeout() -> void:
	queue_free()
