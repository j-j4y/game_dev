extends CharacterBody2D

signal health_depleted 
var max_health = 100.0
var health = max_health
var coin_counter = 0


@onready var coin_label = %CoinLabel


#controlling character movements
func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide() 
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	 
	#damage multipler
	const DAMAGE_RATE = 2.0
	const EXTRA_DAMAGE_MULT = 2.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		var damage = DAMAGE_RATE * overlapping_mobs.size() * delta
		if health <= max_health * 0.5:
			damage *= EXTRA_DAMAGE_MULT
		health -= damage
		health = max(health,0) #makes sure damamge never goes negative
		%ProgressBar.value = health
		
		if health <= 0.0:
			health_depleted.emit()


#controlling coin counter
func _on_coin_shape_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Coin"):
		set_coin(coin_counter + 1)
		print(coin_counter)

func set_coin(new_coin_count: int) -> void:
	coin_counter = new_coin_count
	coin_label.text = "Coin Count: " + str(coin_counter)
