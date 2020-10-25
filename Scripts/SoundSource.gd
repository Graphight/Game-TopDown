extends Area2D


export (int) var cur_radius = 10
export (int) var max_radius = 200
export (int) var growth_rate = 10


func _physics_process(delta):
	cur_radius = min(max_radius, cur_radius + growth_rate)
	update()


func _draw():
	var colour = Color(0.6, 0.6, 0.6, 0.6)
	draw_circle(Vector2(), cur_radius, colour)
