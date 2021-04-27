extends StateMachine



func _ready():
	add_state("idle")
	add_state("run")
	call_deferred("set_state", states.idle)


func _state_logic(delta):
	parent._handle_movement_input(delta)


func _get_transition(delta):
	match state:
		states.idle:
			if parent.move_vec != Vector2(0, 0):
				parent.update_state("RUNNING")
				return states.run
		states.run:
			if parent.move_vec == Vector2(0, 0):
				parent.update_state("IDLE")
				return states.idle


func _enter_state(new_state, old_state):
	# Set animations
	match new_state:
		states.idle:
			pass
		states.run:
			pass


func _exit_state(old_state, new_state):
	pass
