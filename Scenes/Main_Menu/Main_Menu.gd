extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():

	$start_new_game.set_text("New Game")
	$scores.set_text("Scores")
	$quit.set_text("Quit")
	$to_continue.set_text("Continue")
	
func _process(delta):
	if global.to_continue:
		$to_continue.set_disabled(false)
	else:
		$to_continue.set_disabled(true)


func _on_start_new_game_pressed():
	global.clicks = 0
	global.level = global.new_level
	global.quantity = 6.0 + 2*global.level
	
	get_tree().change_scene("Scenes/HTS/HTS.tscn")

func _on_to_continue_pressed():
	global.level = global.to_continue_level
	get_tree().change_scene("Scenes/HTS/HTS.tscn")



func _on_scores_pressed():
	get_tree().change_scene("Scenes/Scores/Scores.tscn")


func _on_quit_pressed():
	get_tree().quit()

