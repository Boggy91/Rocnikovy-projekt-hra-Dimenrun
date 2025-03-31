extends CharacterBody2D

@export var speed: float = 100.0
@export var max_health: int = 5
@export var fall_speed: float = 200.0  # Speed at which the boss falls when dead

var hit = false
var health: int
var player: Node2D = null  # Reference to the player
var following_player: bool = false  # Only follow if player is detected
var dead = false  # New variable to track if boss is dead

@onready var game_manager: Node = %"game manager"
@onready var head_area = $HeadArea  # Head hitbox
@onready var detection_zone = $DetectionZone  # Area2D for detecting player
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_timer = $hit_timer  # Timer for controlling the hit animation duration

func _ready():
	health = max_health
	animated_sprite_2d.animation = "default"  # Default animation when ready

func _physics_process(delta):
	if dead:
		velocity.y += fall_speed * delta  # Apply gravity-like effect
		move_and_slide()
		return  # Stop movement and animation updates if boss is dead
	
	# Check if the boss was hit, and update the animation accordingly
	if hit:
		animated_sprite_2d.animation = "hit"  # Switch to hit animation
	else:
		animated_sprite_2d.animation = "default"  # Switch back to default animation

	# Move the boss towards the player if following
	if following_player and player:
		if not hit:
			var direction = (player.global_position - global_position).normalized()
			velocity = direction * speed
			move_and_slide()

func take_damage():
	if not hit and not dead:  # Prevent taking damage after death
		health -= 1
		print("Boss Health: ", health)
		
		if health <= 0:
			die()

# When the boss takes damage, we start the hit animation
func _on_head_area_body_entered(body):
	if body.is_in_group("player"):  # Check if it's the player
		body.jump()  # Make the player bounce after hitting
		take_damage()
		hit = true  # Set hit state to true
		hit_timer.start()  # Start the timer to reset the hit state

# Player enters detection zone -> Start following
func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		player = body
		following_player = true

# Player leaves detection zone -> Stop following
func _on_detection_zone_body_exited(body):
	if body.is_in_group("player"):
		following_player = false

# When hit timer ends, reset hit state to false
func _on_hit_timer_timeout() -> void:
	hit = false  # Stop the hit animation after the timer finishes

# Die function when boss's health reaches 0
func die():
	dead = true  # Mark the boss as dead
	animated_sprite_2d.animation = "dead"  # Play death animation
	animated_sprite_2d.play()
	set_physics_process(true)  # Allow physics for falling motion
	velocity = Vector2(0, fall_speed)  # Set initial downward velocity
	$dead_timer.start()

func _on_dead_timer_timeout() -> void:
	queue_free()  # Removes the boss from the scene


func _on_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not hit:
			body.hit(400)
			print("Decrease player health")
			game_manager.decrease_health()
