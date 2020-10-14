extends KinematicBody2D


export var MOVE_SPEED = 50
export var DETECTION_RADIUS = 160

onready var timer = $Timer
onready var sensor = $Sensor

var target = null
var stance = "idle"
var rng = RandomNumberGenerator.new()
var vec_to_target = Vector2()


func _ready():
	rng.randomize()


func _process(delta):
	timer.start()


func _physics_process(delta):	
	if stance == "hunting":
		vec_to_target = target.global_position - global_position
	
	vec_to_target = vec_to_target.normalized()
	var collision_entity = move_and_collide(vec_to_target * MOVE_SPEED * delta, false, true, false)


func _draw():
	draw_circle(Vector2(), DETECTION_RADIUS, Color(0.9, 0.9, 0.9, 0.1))

func _on_Sensor_body_entered(body):
	if body.name == "Player":
		target = body
		stance = "hunting"


func _on_Sensor_body_exited(body):
	if body.name == "Player":
		target = null
		stance = "idle"


func _on_Timer_timeout():
	rng.randomize()
	var random_point = Vector2(rng.randi_range(-DETECTION_RADIUS, DETECTION_RADIUS), rng.randi_range(-DETECTION_RADIUS, DETECTION_RADIUS))
	print(random_point)
	
	if stance == "idle":
		vec_to_target = random_point - global_position
	
	timer.start()
