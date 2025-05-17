extends CharacterBody2D


var speed = 100

var player_state

@export var inventory: Inv

var bow_equiped = true
var bow_cooldown = true
var arrow = preload("res://Scenes/arrow.tscn")


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "Idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
	
	
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("left click") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		await get_tree().create_timer(0.5).timeout
		bow_cooldown = true
	
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


func collect(item):
	inventory.insert(item)
