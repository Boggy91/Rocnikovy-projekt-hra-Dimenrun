extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var game_manager: Node = %"game manager"
@onready var sfx_hit: AudioStreamPlayer = $SFX_hit
@onready var sfx_kill: AudioStreamPlayer = $SFX_kill



var killed= false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		print(y_delta)
		if (y_delta > 20):
			print("Destroy enemy")
			sfx_kill.play()
			killed= true
			if killed:
				animated_sprite_2d.animation="killed"
				$killed_timer.start()
				body.jump()
				
		else:
			print("Decrease player health")
			sfx_hit.play()
			game_manager.decrease_health()
			if(x_delta >= 0):
				body.hit(200)
			else:
				body.hit(-200)



func _on_killed_timer_timeout() -> void:
	queue_free()
