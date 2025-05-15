extends Node2D

var money = 100
var wave = 0
var mobs_left = 0
var wave_mobs = [5,6,10,20,40,0]
var wave_speed = [1,1,0.5,0.5,0.3,100]

var instance
var enemy = preload("res://Scenes/Enemy.tscn")
var tower1 = preload("res://Scenes/Tower1.tscn")


var building = false


func _ready():
	$WaveTimer.start()
	
	
func tower_built():
	building = false
	money -= 75


func _process(delta):
	$GUI/Label.text = "Cash:" + str(money)

func _on_WaveTimer_timeout():
	mobs_left = wave_mobs[wave]
	$EnemyTimer.wait_time = wave_speed[wave]
	$EnemyTimer.start()


func _on_EnemyTimer_timeout():
	var instance = enemy.instance()
	$Path2D.add_child(instance)
	mobs_left -= 1
	if mobs_left <= 0:
		$EnemyTimer.stop()
		wave += 1
		if wave < len(wave_mobs):
			$WaveTimer.start()
		else:
			get_tree().change_scene("res://Scenes/Win.tscn")



func _on_TowerSpawn_pressed():
	if building == false and money >= 50:
		instance = tower1.instance()
		add_child(instance)
		building = true


