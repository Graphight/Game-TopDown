extends StateMachine


func _ready():
	add_state("none")
	add_state("shooting")
	add_state("reloading")
	call_deferred("set_state", states.none)


func _state_logic(delta):
	parent._handle_action_inputs()


func _get_transition(delta):
	match state:
		states.none:
			if Input.is_action_pressed("shoot") && can_shoot(parent.gun):
				parent.update_action_display("SHOOTING")
				return states.shooting
			elif Input.is_action_just_pressed("reload") && can_reload(parent.gun):
				parent.update_action_display("RELOADING")
				return states.reloading
		states.shooting:
			if Input.is_action_pressed("shoot"):
				if can_shoot(parent.gun):
					return states.shooting
			elif parent.gun.current_mag == 0:
				parent.update_action_display("RELOADING")
				return states.reloading
			else:
				parent.update_action_display("NONE")
				return states.none
		states.reloading:
			if Input.is_action_pressed("shoot") && can_shoot(parent.gun):
				parent.update_action_display("SHOOTING")
				return states.shooting
			elif can_shoot(parent.gun):
				parent.update_action_display("NONE")
				return states.none


func _enter_state(new_state, old_state):
	match new_state:
		states.shooting:
			parent.gun.fire_gun()
			parent.update_ammo_display()
		states.reloading:
			parent.gun.reload_gun()
		states.none:
			parent.update_ammo_display()


func can_shoot(gun) -> bool:
	var has_ammo = gun.current_mag > 0
	
	return has_ammo && not gun.is_shooting && not gun.is_reloading


func can_reload(gun) -> bool:
	var mag_not_full = gun.current_mag < gun.MAG_SIZE
	
	return mag_not_full && not gun.is_shooting && not gun.is_reloading
