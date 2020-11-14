extends Node2D

export var BULLET_SPEED = 200
export var BULLET_DAMAGE = 1
export var FIRE_RATE = 3 # Attacks per second
export var MAG_SIZE = 10
export var RELOAD_TIME = 1 # Time in seconds

onready var muzzle = $Muzzle

var projectile = preload("res://Scenes/Misc/Projectile.tscn")

var can_fire = true
var current_mag = MAG_SIZE


func reload_gun():
	print("Reloading")
	yield(get_tree().create_timer(RELOAD_TIME), "timeout")
	current_mag = MAG_SIZE
	can_fire = true


func fire_gun():
	if can_fire:
		can_fire = false
		
		if current_mag <= 0:
			reload_gun()
		else:
			spawn_bullet()
			yield(get_tree().create_timer(1.0 / FIRE_RATE), "timeout")
		
		can_fire = true


func spawn_bullet():
	var projectile_instance = projectile.instance()
	muzzle.rotation = get_angle_to(get_global_mouse_position())
	projectile_instance.position = muzzle.get_global_position()
	projectile_instance.rotation = global_rotation
	projectile_instance.damage = BULLET_DAMAGE
	projectile_instance.PROJECTILE_SPEED = BULLET_SPEED
	get_parent().get_parent().add_child(projectile_instance)
	current_mag -= 1
