extends Node2D

@onready var timer: Timer = %CoinSpawn

func spawn_mob():
	var new_mob = preload("res://enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


const COIN = preload("res://coin.tscn")

func spawn_coin() -> void:
	var new_coin = COIN.instantiate()
	new_coin.position = Vector2(randf_range(0, 1000), randf_range(0, 800))
	add_child(new_coin)

func _on_coin_spawn_timeout() -> void:
	spawn_coin()

func _on_timer_timeout() -> void:
	spawn_mob()
	#%EnemySpawnTime.wait_time = 2.0 #overrides timer wait time


func _on_player_health_depleted() -> void:
	%"Game Over".visible = true
	get_tree().paused = true
	
	

#changes BG after set time
func _on_background_change_timeout() -> void:
#	%NewBG.self_modulate = Color.RED
	%NewBG.visible = false
	%FirstBG.visible = true
