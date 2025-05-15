extends Node2D


onready var Head = $Tower

var bullet = preload("res://Scenes/Bullet.tscn")

var enemies = []
var current_enemy
var building = true

func _physics_process(delta):
	if enemies != []:
		current_enemy = enemies[0]
		Head.look_at(current_enemy.global_position)

func _on_Sight_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies.append(area)


func _on_Sight_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies.erase(area)


func _on_ShootingTimer_timeout():
	if current_enemy:
		if enemies:
			if current_enemy == enemies[0]:
				var b = bullet.instance()
				b.global_position = global_position
				b.target = current_enemy
				get_parent().add_child(b)

