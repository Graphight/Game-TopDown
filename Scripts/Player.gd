extends KinematicBody2D


export var MOVE_SPEED = 100
export var SPRINT_MULTIPLIER = 1.75


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
	
	var collision_entity = move_and_collide(move_vec * speed * delta, false, true, false)



