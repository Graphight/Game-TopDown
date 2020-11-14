extends Node2D


var enemy = preload("res://Scenes/Entities/Enemy.tscn")


func _process(delta):
	if Input.is_action_just_pressed("spawn"):
		spawn_enemy()


func spawn_enemy():
	var enemy_instance = enemy.instance()
	enemy_instance.position = get_global_mouse_position()
	add_child(enemy_instance)
