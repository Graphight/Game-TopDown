extends KinematicBody2D


export var MOVE_SPEED = 50
export var DETECTION_RADIUS = 160
export var LEVEL = 1
export var BASE_HP = 100.0
export var BASE_ARMOUR = 5.0
export var HP_SCALING = 50.0
export var ARMOUR_SCALING = 0.6

onready var sensor = $Sensor
onready var hp_bar = $HP_bar
onready var target_pos = global_position

var target = null
var stance = "idle"
var vec_to_target = Vector2()
var additional_forces = Vector2()
var current_hit_points = BASE_HP + (HP_SCALING*(LEVEL - 1.0))
var armour = BASE_ARMOUR + (ARMOUR_SCALING*(LEVEL - 1.0)^(1.5))


func _ready():
	hp_bar.max_value = BASE_HP + (HP_SCALING*(LEVEL - 1.0))
	hp_bar.value = BASE_HP + (HP_SCALING*(LEVEL - 1.0))
	set_process(true)


func _process(delta):
	update()


func _physics_process(delta):
	if stance == "fighting":
		# Move toward target
		vec_to_target = target_pos - global_position
		# Update target position to continue following
		target_pos = target.position
	elif stance == "hunting":
		# Move toward last seen place of target then stop
		if target_pos.distance_to(position) > 1:
			vec_to_target = target_pos - global_position
		else:
			stance = "idle"
			vec_to_target = Vector2()
	
	if not additional_forces == Vector2():
		vec_to_target += additional_forces
		additional_forces = Vector2()
		
	vec_to_target = vec_to_target.normalized()
	
	var collision_entity = move_and_collide(vec_to_target * MOVE_SPEED * delta, false, true, false)


func _draw():
	var line_colour = Color(0.0, 0.0, 1.0, 0.7)
	if stance == "fighting":
		line_colour = Color(1.0, 0.0, 0.0, 0.7)
	elif stance == "hunting":
		line_colour = Color(0.0, 1.0, 0.0, 0.7)
	draw_line(Vector2(), target_pos - position, line_colour, 3)
	
	draw_circle(Vector2(), DETECTION_RADIUS, line_colour - Color(0.0, 0.0, 0.0, 0.5))


func kill():
	queue_free()


func damage(value, bullet_force):
	additional_forces = bullet_force
	current_hit_points -= value * (150.0/(150.0+armour))
	hp_bar.value = current_hit_points
	if current_hit_points <= 0:
		kill()


func _on_Sensor_body_entered(body):
	if body.name == "Player":
		target = body
		target_pos = body.position
		stance = "fighting"


func _on_Sensor_body_exited(body):
	if body.name == "Player":
		target = null
		target_pos = body.position
		stance = "hunting"
