extends RigidBody2D

@export var speed: float = 300.0  # Initial speed
@export var max_speed: float = 300.0  # Maximum allowed speed
@export var lifetime: float = 50.0  # Time before auto-explosion
@export var upward_force: float = -500.0  # Force applied upwards (inverted gravity)
@onready var sfx_hit: AudioStreamPlayer = $SFX_hit

var has_collided: bool = false  # Flag to stop movement after collision
var game_manager: Node  # Assigned from spawner

@onready var explosion_timer = $explosion_timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	gravity_scale = 0
	explosion_timer.start(lifetime)  
	animated_sprite_2d.animation = "idle"

func set_target(player: Node2D):
	if player:
		var direction = (player.global_position - global_position).normalized()
		apply_impulse(direction * speed)

func _physics_process(delta):
	linear_velocity.y = upward_force

	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

	if has_collided:
		linear_velocity = Vector2.ZERO

func explode():
	animated_sprite_2d.animation = "explode"
	animated_sprite_2d.play()
	await animated_sprite_2d.animation_finished
	queue_free()

func _on_collision_body_entered(body):
	if not has_collided:
		has_collided = true
		if body.is_in_group("player"):
			print("Decrease player health")
			if game_manager:
				game_manager.decrease_health()
				sfx_hit.play()
			else:
				print("GameManager is null!")
		explode()
