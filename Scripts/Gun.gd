extends Node2D

export var BULLET_SPEED = 0
export var BULLET_DAMAGE= 0
export var FIRE_RATE = 0
export var MAG_SIZE = 0
export var RELOAD_TIME = 0
export var BULLET_SHOTS = 0
export var BULLET_SPREAD = 0
export var GUN_MODE = "single"

onready var muzzle = $Muzzle

var projectile = preload("res://Scenes/Misc/Projectile.tscn")

var is_reloading = false
var is_shooting = false
var current_mag = MAG_SIZE


func ready():
	load_base_stats("pistol")


func load_base_stats(gun_name):
	var file = File.new()
	file.open("res://Resources/Weapons/gun_stats.json", file.READ)
	var json_string = file.get_as_text()
	var json_result = JSON.parse(json_string).result
	file.close()
	
	BULLET_SPEED = json_result[gun_name]["bullet_speed"]
	BULLET_DAMAGE = json_result[gun_name]["bullet_damage"]
	FIRE_RATE = json_result[gun_name]["fire_rate"]
	MAG_SIZE = json_result[gun_name]["mag_size"]
	RELOAD_TIME = json_result[gun_name]["reload_time"]
	BULLET_SHOTS = json_result[gun_name]["bullet_shots"]
	BULLET_SPREAD = json_result[gun_name]["bullet_spread"]
	GUN_MODE = json_result[gun_name]["mode"]
	current_mag = MAG_SIZE
	

func fire_gun():
	is_shooting = true
	
	if GUN_MODE == "spread":
		for bullet in range(BULLET_SHOTS):
			var offset = (BULLET_SPREAD / 2) - (((bullet - 1) * BULLET_SPREAD) / (BULLET_SHOTS - 1))
			spawn_bullet(offset)
	elif GUN_MODE == "burst":
		for bullet in range(BULLET_SHOTS):
			yield(get_tree().create_timer(0.05), "timeout")
			spawn_bullet(0)
	else:
		spawn_bullet(0)
	current_mag -= 1
	yield(get_tree().create_timer(1.0 / FIRE_RATE), "timeout")
	
	is_shooting = false


func reload_gun():
	is_reloading = true
	yield(get_tree().create_timer(RELOAD_TIME), "timeout")
	current_mag = MAG_SIZE
	is_reloading = false


func spawn_bullet(offset):
	var projectile_instance = projectile.instance()
	muzzle.rotation = get_angle_to(get_global_mouse_position())
	projectile_instance.position = muzzle.get_global_position()
	projectile_instance.rotation = global_rotation + deg2rad(offset)
	projectile_instance.damage = BULLET_DAMAGE
	projectile_instance.PROJECTILE_SPEED = BULLET_SPEED
	get_parent().get_parent().add_child(projectile_instance)
