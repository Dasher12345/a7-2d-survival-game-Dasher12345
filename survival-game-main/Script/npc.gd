extends CharacterBody2D


const speed = 30
var current_state = IDLE

var direction = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}


func _ready() -> void:
	randomize()
	start_pos = position

func _process(delta: float) -> void:
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	
	elif current_state == 2 and !is_chatting:
		if direction.x == -1:
			$AnimatedSprite2D.play("walk-L")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk-R")
		if direction.y == -1:
			$AnimatedSprite2D.play("walk-U")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk-D")
	
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				direction = choose([Vector2.RIGHT, Vector2.UP, Vector2.DOWN, Vector2.LEFT])
			MOVE:
				move(delta)
		
		
		if Input.is_action_just_pressed("chat"):
			print("chatting with npc")
			is_roaming = false
			is_chatting = true
			$AnimatedSprite2D.play("idle")


func choose(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		position += direction * speed * delta


func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_in_chat_zone = true


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_chat_zone = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
