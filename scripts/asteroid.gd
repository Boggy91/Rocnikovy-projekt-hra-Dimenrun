extends RigidBody2D

@export var speed: float = 300.0  # Initial speed
@export var max_speed: float = 300.0  # Maximum allowed speed
@export var lifetime: float = 50.0  # Time before auto-explosion

var has_collided: bool = false  # Flag to stop movement after collision

@onready var game_manager: Node = %"game manager"
@onready var explosion_timer = $explosion_timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	explosion_timer.start(lifetime)  # Start countdown to explosion
	animated_sprite_2d.animation = "idle"

func set_target(player: Node2D):
	if player:
		var direction = (player.global_position - global_position).normalized()
		apply_impulse(direction * speed)  # Apply initial force

func _physics_process(delta):
	# Limit the asteroid's maximum velocity
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	# Stop movement after collision
	if has_collided:
		linear_velocity = Vector2.ZERO

func explode():
	animated_sprite_2d.animation = "explode"
	animated_sprite_2d.play()
	await animated_sprite_2d.animation_finished
	queue_free()

func _on_explosion_timer_timeout():
	$kill_timer.start()
	explode()

func _on_collision_body_entered(body):
	if not has_collided:
		has_collided = true
		linear_velocity = Vector2.ZERO  # Stop movement
		if body.is_in_group("player"):
			print("Decrease player health")
			game_manager.decrease_health()
		$kill_timer.start()
		explode()

func _on_kill_timer_timeout() -> void:
	queue_free()
