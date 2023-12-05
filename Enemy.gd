extends CharacterBody2D

var speed = 45
var player_chase = false
var player 

var health = 40
var player_attack_zone = false

var can_take_damage = true

@onready var animation = get_node("AnimatedSprite2D")

func _physics_process(delta):
	deal_with_damage()
	movement(delta)


func movement(delta):
	if player_chase == true:
		self.position += (player.position - self.position).normalized() * speed * delta
		move_and_collide(Vector2(0,0))
		animation.play("front_walk")
		if player.position.x - position.x < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		animation.play("idle")	

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false
	
func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_attack_zone = true

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_attack_zone = false

func enemy():
	pass
	
func deal_with_damage():
	if player_attack_zone and Global.player_current_attack:
		if can_take_damage == true:
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health:" + str(health))
			if health <= 0:
				queue_free()
			



func _on_take_damage_cooldown_timeout():
	can_take_damage = true
