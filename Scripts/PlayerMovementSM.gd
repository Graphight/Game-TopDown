extends StateMachine



func _ready():
	add_state("idle")
	add_state("running")
	add_state("sprinting")
	call_deferred("set_state", states.idle)


func _state_logic(delta):
	parent._handle_movement_input(delta)


func _get_transition(delta):
	match state:
		states.idle:
			if parent.move_vec != Vector2(0, 0):
				parent.update_state("RUNNING")
				return states.running
		states.running:
			if parent.is_sprinting == true:
				parent.update_state("SPRINITNG")
				return states.sprinting
			elif parent.move_vec == Vector2(0, 0):
				parent.update_state("IDLE")
				return states.idle
		states.sprinting:
			if parent.is_sprinting == false:
				parent.update_state("RUNNING")
				return states.running
			elif parent.move_vec == Vector2(0, 0):
				parent.update_state("IDLE")
				return states.idle


func _enter_state(new_state, old_state):
	# Set animations
	match new_state:
		states.idle:
			pass
		states.running:
			pass


func _exit_state(old_state, new_state):
	pass
