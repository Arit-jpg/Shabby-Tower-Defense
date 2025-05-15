extends Node2D

onready var Head = $Tower

var bullet = preload("res://Scenes/Bullet.tscn")

var enemies = []
var current_enemy
var building = true

func _physics_process(delta):
	if building == false:
		if enemies != []:
			current_enemy = enemies[0]
			Head.look_at(current_enemy.global_position)
	else:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("click"):
			building = false
			get_parent().tower_built()

func _on_Sight_area_entered(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.append(area)


func _on_Sight_area_exited(area):
	if area.is_in_group("Enemy"):
		if building == false:
			enemies.erase(area)


func _on_ShootingTimer_timeout():
	if building == false:
		if current_enemy:
			if enemies:
				if current_enemy == enemies[0]:
					var b = bullet.instance()
					b.global_position = global_position
					b.target = current_enemy
					get_parent().add_child(b)

