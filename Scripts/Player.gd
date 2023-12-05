extends CharacterBody2D

const speed = 100

var current_dir = "none"

var enemy_in_range = false
var enemy_attack_cd = true

var health = 100
var alive = true

var attack_ip = false 


func _physics_process(delta):
	attack()
	player_movement(delta)
	enemy_attack()
	if health <= 0:
		queue_free()
	
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1, current_dir)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):	
		current_dir = "left"
		play_anim(1, current_dir)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):	
		current_dir = "down"
		play_anim(1, current_dir)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):	
		current_dir = "up"
		play_anim(1, current_dir)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_anim(0, current_dir)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement, dir): 
	var anim = $AnimatedSprite2D
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")		

	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")		
			
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
			
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")


func _on_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_hitbox_body_exited(body):
	if body.has_method("enemy"):  #if body.name = "Player"
		enemy_in_range = false
		
func enemy_attack():
	if enemy_in_range and enemy_attack_cd == true:
		self.health -= 20
		enemy_attack_cd = false
		$attack_cooldown.start()
		print(health)
	
func player():
	pass

func _on_attack_cooldown_timeout():
	enemy_attack_cd = true

func attack():
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if Input.is_action_just_pressed("attack"):
		attack_ip = true
		if dir == "right":
			anim.flip_h = false
			anim.play("side_attack")
			$deal_attack_timer.start()
		if dir == "left":
			anim.flip_h = true
			anim.play("side_attack")
			$deal_attack_timer.start()
		if dir == "down":
			anim.flip_h = false
			anim.play("front_attack")
			$deal_attack_timer.start()
		if dir == "up":
			anim.flip_h = false
			anim.play("back_attack")
			$deal_attack_timer.start()
		Global.player_current_attack = true



func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false


