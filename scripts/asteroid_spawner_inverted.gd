extends Node2D

@export var asteroid_scene: PackedScene  # Assign your asteroid scene in the Inspector
@export var spawn_interval: float = 1.0  # Time between spawns

@onready var spawn_line: StaticBody2D = $spawn_line
@onready var spawn_timer = $SpawnTimer
@onready var game_manager: Node = %"game manager"  # Adjust this path if needed

func _ready():
	spawn_timer.wait_time = spawn_interval
	spawn_timer.start()

func spawn_asteroid(position: Vector2):
	var asteroid = asteroid_scene.instantiate() as RigidBody2D
	asteroid.global_position = position

	# Inject the game manager reference
	asteroid.game_manager = game_manager

	get_parent().add_child(asteroid)

func _on_spawn_timer_timeout() -> void:
	if spawn_line:
		var segment_shape = spawn_line.get_child(0).shape as SegmentShape2D
		if segment_shape:
			var start_pos = spawn_line.to_global(segment_shape.a)
			var end_pos = spawn_line.to_global(segment_shape.b)
			var spawn_position = start_pos.lerp(end_pos, randf())  # Pick random point on the line
			spawn_asteroid(spawn_position)
