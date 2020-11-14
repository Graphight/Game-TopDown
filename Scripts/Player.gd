extends KinematicBody2D


export var MOVE_SPEED = 100
export var SPRINT_MULTIPLIER = 1.75

var possible_guns = [
	"pistol",
	"smg",
	"shotgun",
	"sniper",
	"assault"
]
var current_index = 0

onready var gun = $Gun


func _ready():
	gun.load_base_stats("pistol")


func _process(delta):
	look_at(get_global_mouse_position())


func _physics_process(delta):
	var speed = MOVE_SPEED
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	
	if Input.is_action_pressed("sprint"):
		speed = MOVE_SPEED * SPRINT_MULTIPLIER
	else:
		speed = MOVE_SPEED
	
	if Input.is_action_pressed("shoot"):
		$Gun.fire_gun()
	
	if Input.is_action_just_pressed("cycle_weapon"):
		current_index += 1
		if current_index >= len(possible_guns):
			current_index = 0
		var gun_name = possible_guns[current_index]
		print("Switching to " + gun_name)
		gun.load_base_stats(possible_guns[current_index])
	
	var collision_entity = move_and_collide(move_vec * speed * delta, false, true, false)



