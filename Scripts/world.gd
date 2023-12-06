extends Node2D


func _process(delta):
	change_scenes()

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			Global.finish_changescene()
			get_tree().change_scene_to_file("res://Scenes/cliff_side.tscn")


func _on_cliff_switch_point_body_entered(body):
		if body.name == "Player":
			Global.transition_scene = true


func _on_cliff_switch_point_body_exited(body):
	if body.name == "Player":
		Global.transition_scene = false
