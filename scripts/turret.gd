extends Node2D

@onready var ray_cast = $RayCast2D
@onready var timer = $Timer
@export var ammo: PackedScene

var player

func _ready():
	# Pokúsi sa nájsť uzol 'player'
	player = get_node("Scene Objects/CharacterBody2D")
	if player == null:
		print_tree()  # Vypíše celú hierarchiu uzlov pre debugging
		print("Chyba: Uzol 'player' sa nenašiel!")
		
func _physics_process(_delta):
	_aim()
	_check_player_collision()

func _aim():
	if player != null:
		ray_cast.target_position = to_local(player.position)
	else:
		ray_cast.target_position = Vector2.ZERO  # Predvolená hodnota, ak 'player' nie je nájdený

func _check_player_collision():
	if player != null:
		if ray_cast.get_collider() == player and timer.is_stopped():
			timer.start()
		elif ray_cast.get_collider() != player and not timer.is_stopped():
			timer.stop()

func _on_timer_timeout():
	_shoot()

func _shoot():
	if ammo != null:  # Skontroluj, či je 'ammo' definované
		var bullet = ammo.instantiate()
		bullet.position = position
		bullet.direction = (ray_cast.target_position).normalized()
		get_tree().current_scene.add_child(bullet)
	else:
		print("Chyba: 'ammo' nie je nastavené!")
