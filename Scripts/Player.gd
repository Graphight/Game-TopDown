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
var move_vec = Vector2(0, 0)

var is_sprinting = false

onready var gun = $Gun
onready var sprite = $Sprite
onready var current_movement = $HUD/CurrentMovement
onready var current_action = $HUD/CurrentAction
onready var current_gun = $HUD/CurrentGun
onready var current_ammo = $HUD/CurrentAmmo


func _ready():
	gun.load_base_stats("pistol")
	current_gun.text = possible_guns[current_index]
	current_ammo.text = str(gun.current_mag)


func _process(delta):
	sprite.look_at(get_global_mouse_position())
	gun.look_at(get_global_mouse_position())


func _handle_movement_input(delta):
	var speed = MOVE_SPEED
	move_vec = Vector2(0, 0)
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
		is_sprinting = true
		speed = MOVE_SPEED * SPRINT_MULTIPLIER
	else:
		is_sprinting = false
		speed = MOVE_SPEED
	
	var collision_entity = move_and_collide(move_vec * speed * delta, false, true, false)


func _handle_action_inputs():
	if Input.is_action_just_pressed("cycle_weapon"):
		current_index += 1
		if current_index >= len(possible_guns):
			current_index = 0
		var gun_name = possible_guns[current_index]
		print("Switching to " + gun_name)
		gun.load_base_stats(possible_guns[current_index])
		current_gun.text = gun_name
		current_ammo.text = str(gun.MAG_SIZE)


func update_movement_display(new_state):
	current_movement.text = new_state


func update_action_display(new_state):
	current_action.text = new_state


func update_ammo_display():
	current_ammo.text = str(gun.current_mag)
