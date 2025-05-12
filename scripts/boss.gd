extends CharacterBody2D

@export var speed: float = 100.0
@export var dash_speed: float = 400.0  # Speed during dash
@export var max_health: int = 5
@export var fall_speed: float = 200.0
@export var boss_hearts: Array[Node]  # Hearts for the boss (drag in the hearts from the scene)

var hit = false
var health: int
var player: Node2D = null
var following_player: bool = false
var dead = false
var dashing = false  # New flag for dashing

@onready var game_manager: Node = %"game manager"
@onready var head_area = $HeadArea
@onready var detection_zone = $DetectionZone
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_timer = $hit_timer
@onready var dash_timer: Timer = $dash_timer
@onready var dashing_timer: Timer = $dashing_timer

func _ready():
	health = max_health
	animated_sprite_2d.animation = "default"
	dash_timer.start()  # Start dash timer at the beginning
	update_boss_hearts_display()  # Initialize the heart display when the boss is created

func _physics_process(delta):
	if dead:
		velocity.y += fall_speed * delta
		move_and_slide()
		return

	if hit:
		animated_sprite_2d.animation = "hit"
	else:
		animated_sprite_2d.animation = "default"

	if following_player and player:
		if not hit:
			var direction = (player.global_position - global_position).normalized()
			if dashing:
				velocity = direction * dash_speed
				animated_sprite_2d.animation = "dash"
			else:
				velocity = direction * speed
			move_and_slide()

func take_damage():
	if not hit and not dead:
		health -= 1
		print("Boss Health: ", health)
		update_boss_hearts_display()  # Update hearts display after taking damage
		if health <= 0:
			die()

func _on_head_area_body_entered(body):
	if body.is_in_group("player"):
		body.jump()
		take_damage()
		hit = true
		hit_timer.start()

func _on_detection_zone_body_entered(body):
	if body.is_in_group("player"):
		player = body
		following_player = true

func _on_detection_zone_body_exited(body):
	if body.is_in_group("player"):
		following_player = false

func _on_hit_timer_timeout() -> void:
	hit = false

func die():
	dead = true
	animated_sprite_2d.animation = "dead"
	animated_sprite_2d.play()
	set_physics_process(true)
	velocity = Vector2(0, fall_speed)
	$dead_timer.start()

func _on_dead_timer_timeout() -> void:
	queue_free()
	get_tree().change_scene_to_file("res://scenes/GAME/credits.tscn")

func _on_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not hit:
		body.hit(400)
		print("Decrease player health")
		game_manager.decrease_health()

# Start dashing when dash_timer times out
func _on_dash_timer_timeout() -> void:
	dashing = true
	dashing_timer.start()

# Stop dashing after 0.5 seconds
func _on_dashing_timer_timeout() -> void:
	dashing = false
	dash_timer.start()  # Restart the cooldown for the next dash

# Update the hearts display for the boss
func update_boss_hearts_display():
	for h in range(boss_hearts.size()):
		if h < health:
			boss_hearts[h].show()
		else:
			boss_hearts[h].hide()
