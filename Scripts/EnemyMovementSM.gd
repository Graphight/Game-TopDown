extends StateMachine
#
#
#
#if stance == "fighting":
#		# Move toward target
#		vec_to_target = target_pos - global_position
#		# Update target position to continue following
#		target_pos = target.position
#		target_pos = target.position
#	elif stance == "hunting":
#		# Move toward last seen place of target then stop
#		if target_pos.distance_to(position) > 1:
#			vec_to_target = target_pos - global_position
#		else:
#			stance = "idle"
#			vec_to_target = Vector2()
#
#	if not additional_forces == Vector2():
#		vec_to_target += additional_forces
#		additional_forces = Vector2()
#
#	vec_to_target = vec_to_target.normalized()
#
#	var collision_entity = move_and_collide(vec_to_target * MOVE_SPEED * delta, false, true, false)
#
#
#func _ready():
#	add_state("idle")
#	add_state("fighting")
#	add_state("hutning")
#	call_deferred("set_state", states.idle)
#
#
#func _state_logic(delta):
#	parent._handle_movement(delta)
#
#
#func _get_transition(delta):
#	match state:
#		states.idle:
#			if parent.move_vec != Vector2(0, 0):
#				parent.update_movement_display("RUNNING")
#				return states.running
#		states.fighting:
#			if parent.is_sprinting == true:
#				parent.update_movement_display("SPRINITNG")
#				return states.sprinting
#			elif parent.move_vec == Vector2(0, 0):
#				parent.update_movement_display("IDLE")
#				return states.idle
#		states.hunting:
#			if parent.is_sprinting == false:
#				parent.update_movement_display("RUNNING")
#				return states.running
#			elif parent.move_vec == Vector2(0, 0):
#				parent.update_movement_display("IDLE")
#				return states.idle
#
#
#func _enter_state(new_state, old_state):
#	# Set animations
#	match new_state:
#		states.idle:
#			pass
#		states.running:
#			pass
#
