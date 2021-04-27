extends StateMachine



func _ready():
	add_state("idle")
	add_state("shooting")
	add_state("reloading")
	call_deferred("set_state", states.idle)


func _state_logic(delta):
	parent._handle_action_inputs()


func _get_transition(delta):
	match state:
		states.idle:
			pass
		states.run:
			pass


func _enter_state(new_state, old_state):
	pass


func _exit_state(old_state, new_state):
	pass