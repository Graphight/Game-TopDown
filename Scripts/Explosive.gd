extends RigidBody2D


var PROJECTILE_SPEED = 100

var impact_force = Vector2()
var impact_damage = 1
var life_time = 5
var blast_force = 2
var blast_radius = 50
var frag_particles = 0

func _ready():
	impact_force = Vector2(PROJECTILE_SPEED, 0).rotated(rotation)
	apply_impulse(Vector2(), impact_force)
	self_destruct()

func _explosion(body):
	if body.name == "Enemy":
		blast_force = Vector2(body.get_global_position() - get_global_position(), 0).rotated(rotation)
		apply_impulse(Vector2(), blast_force)
		self_destruct()

func self_destruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()


func _on_Explosive_body_entered(body):
	if body.has_method("damage"):
		body.damage(impact_damage, impact_force)
		
		queue_free()

