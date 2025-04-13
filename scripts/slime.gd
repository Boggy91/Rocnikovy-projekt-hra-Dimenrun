extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager: Node = %"game manager"



var killed= false

func _on_area_2d_body_entered(body: Node2D) -> void:
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
			if(x_delta >= 0):
				body.hit(300)
			else:
				body.hit(-300)



func _on_killed_timer_timeout() -> void:
	queue_free()
