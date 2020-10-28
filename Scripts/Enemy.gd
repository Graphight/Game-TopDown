extends KinematicBody2D


export var MOVE_SPEED = 50
export var DETECTION_RADIUS = 160

onready var sensor = $Sensor
onready var target_pos = global_position

var target = null
var stance = "idle"
var vec_to_target = Vector2()


func _ready():
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
	
	vec_to_target = vec_to_target.normalized()
	var collision_entity = move_and_collide(vec_to_target * MOVE_SPEED * delta, false, true, false)


func _draw():
	var line_colour = Color(0.0, 0.0, 1.0, 0.7)
	if stance == "fighting":
		line_colour = Color(1.0, 0.0, 0.0, 0.7)
	elif stance == "hunting":
		line_colour = Color(0.0, 1.0, 0.0, 0.7)
	draw_line(Vector2(), target_pos - global_position, line_colour, 3)
	
	draw_circle(Vector2(), DETECTION_RADIUS, line_colour - Color(0.0, 0.0, 0.0, 0.5))


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
