extends Area2D

var move = Vector2.ZERO
var speed = 20
var look_v = Vector2.ZERO
var target

func _ready():
	if target != null:
		$Sprite.look_at(target.global_position)
		look_v = target.global_position - global_position
		
func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_v, delta)
	move = move.normalized() * speed
	global_position += move


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
