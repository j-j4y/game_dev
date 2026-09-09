extends CharacterBody2D

signal health_depleted 
var max_health = 100.0
var health = max_health

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide() 
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	 
	const DAMAGE_RATE = 5.0
	const EXTRA_DAMAGE_MULT = 2.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		var damage = DAMAGE_RATE * overlapping_mobs.size() * delta
		if health <= max_health * 0.5:
			damage *= EXTRA_DAMAGE_MULT
		health -= damage
		health = max(health,0)
		%ProgressBar.value = health
		
		if health <= 0.0:
			health_depleted.emit()
