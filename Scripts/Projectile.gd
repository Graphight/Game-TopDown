extends RigidBody2D


var PROJECTILE_SPEED = 100

var bullet_force = Vector2()
var damage = 1
var life_time = 5


func _ready():
	bullet_force = Vector2(PROJECTILE_SPEED, 0).rotated(rotation)
	apply_impulse(Vector2(), bullet_force)
	self_destruct()


func self_destruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()


func _on_Projectile_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage, bullet_force)
		queue_free()
