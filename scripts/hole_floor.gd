extends StaticBody2D

@onready var white_hole: StaticBody2D = $"." 
@onready var red_hole: StaticBody2D = $"../Red_hole"
@onready var yellow_hole: StaticBody2D = $"../Yellow_hole"
@onready var blue_hole: StaticBody2D = $"../Blue_hole"
@onready var green_hole: StaticBody2D = $"../Green_hole"
@onready var orange_hole: StaticBody2D = $"../Orange_hole"

@onready var white_box: RigidBody2D = $"../../Boxes/White_box"
@onready var red_box: RigidBody2D = $"../../Boxes/Red_box"
@onready var yellow_box: RigidBody2D = $"../../Boxes/Yellow_box"
@onready var blue_box: RigidBody2D = $"../../Boxes/Blue_box"
@onready var green_box: RigidBody2D = $"../../Boxes/Green_box"
@onready var orange_box: RigidBody2D = $"../../Boxes/Orange_box"


@onready var finish: Area2D = $"../../../finish"

@onready var block_red: CollisionShape2D = $BLOCK_RED
@onready var block_yellow: CollisionShape2D = $"../Red_hole/BLOCK_YELLOW"
@onready var block_blue: CollisionShape2D = $"../Yellow_hole/BLOCK_BLUE"
@onready var block_green: CollisionShape2D = $"../Blue_hole/BLOCK_GREEN"
@onready var block_orange: CollisionShape2D = $"../Green_hole/BLOCK_ORANGE"


# Hole area detection functions
func _on_area_white(body: RigidBody2D) -> void:
	if body == white_box:
		white_hole.position = Vector2(1729, 802.3)
		block_red.position = Vector2(100000, 100000)
func _on_area_red(body: RigidBody2D) -> void:
	if body == red_box:
		red_hole.position = Vector2(1863, 802.3)
		block_yellow.position = Vector2(100000, 100000)

func _on_area_yellow(body: RigidBody2D) -> void:
	if body == yellow_box:
		yellow_hole.position = Vector2(1998, 802.3)
		block_blue.position = Vector2(100000, 100000)

func _on_area_blue(body: RigidBody2D) -> void:
	if body == blue_box:
		blue_hole.position = Vector2(2132, 802.3)
		block_green.position = Vector2(100000, 100000)

func _on_area_green(body: RigidBody2D) -> void:
	if body == green_box:
		green_hole.position = Vector2(2267, 802.3)
		block_orange.position = Vector2(100000, 100000)
		
func _on_area_orange(body: RigidBody2D) -> void:
	if body == orange_box:
		orange_hole.position = Vector2(365, 802.3)
		finish.position = Vector2(1093, 782)
		
