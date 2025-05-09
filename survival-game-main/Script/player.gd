extends CharacterBody2D


var speed = 100

var player_state


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "Idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
	
	
	velocity = direction * speed
	move_and_slide()    
	
	play_anim(direction)


func play_anim(direction):
	if player_state == "Idle":
		$AnimatedSprite2D.play("Idle")
	if player_state == "walking":
		if direction.y == -1:
			$AnimatedSprite2D.play("U-walk")
		if direction.y == 1:
			$AnimatedSprite2D.play("D-walk")
		if direction.x == 1:
			$AnimatedSprite2D.play("R-walk")
		if direction.x == -1:
			$AnimatedSprite2D.play("L-walk")
		
		
		if direction.x > 0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("DR-walk")
		if direction.x > 0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("UR-walk")
		if direction.x < -0.5 and direction.y > 0.5:
			$AnimatedSprite2D.play("DL-walk")
		if direction.x < -0.5 and direction.y < -0.5:
			$AnimatedSprite2D.play("UL-walk")



func player():
	pass
