extends Node2D


func _process(delta):
	change_scenes()

func _on_cliff_side_transition_point_body_entered(body):
	if body.name == "Player":
		Global.transition_scene = true
		
func _on_cliff_side_transition_point_body_exited(body):
	if body.name == "Player":
		Global.transition_scene = false

func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://Scenes/cliff_side.tscn")
			Global.finish_changescene()
