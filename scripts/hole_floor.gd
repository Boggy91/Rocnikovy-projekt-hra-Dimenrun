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


var white_stav = false
var red_stav = false
var yellow_stav = false
var blue_stav = false
var green_stav = false
var orange_stav = false

var stav = 0

@onready var finish: Area2D = $"../../../finish"



func _on_area_white(body: RigidBody2D) -> void:
	if body==white_box:
		white_hole.position = Vector2(1729, 802.3)
		white_stav = true
		print(white_stav)
		check()

func _on_area_red(body: RigidBody2D) -> void:
	if body==red_box:
		red_hole.position = Vector2(1863, 802.3)
		red_stav = true
		check()

func _on_area_yellow(body: RigidBody2D) -> void:
	if body==yellow_box:
		yellow_hole.position = Vector2(1998, 802.3)
		yellow_stav = true
		check()

func _on_area_blue(body: RigidBody2D) -> void:
	if body==blue_box:
		blue_hole.position = Vector2(2132, 802.3)
		blue_stav = true
		check()

func _on_area_green(body: RigidBody2D) -> void:
	if body==green_box:
		green_hole.position = Vector2(2267, 802.3)
		green_stav = true
		check()

func _on_area_orange(body: RigidBody2D) -> void:
	if body==orange_box:
		orange_hole.position = Vector2(365, 802.3)
		orange_stav = true
		check()
		
func check():
	if white_stav == true:
		stav += 1
		print(stav)
	if red_stav == true:
		stav += 1
		print(stav)
	if yellow_stav == true:
		stav += 1
		print(stav)
	if blue_stav == true:
		stav += 1
		print(stav)
	if green_stav == true:
		stav += 1
		print(stav)
	if orange_stav == true:
		stav += 1
		print(stav)
	
#finish.position = Vector2(1093, 782)
