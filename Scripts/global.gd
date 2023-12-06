extends Node


var player_current_attack = false

var current_scene = "world"

var transition_scene = false

var player_exit_cliffside_poz_x = 0
var player_exit_cliffside_poz_y = 0

var player_start_position_x = 0
var player_start_position_y = 0


func finish_changescene():
	if transition_scene == true:
		transition_scene == false
		if current_scene == "world":
			current_scene = "cliff_side"
		else:
			current_scene = "world"
