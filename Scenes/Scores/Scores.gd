extends Node2D


func _ready():
	
	
	$scores/main_clicks.set_text("Main Game Completed - %s - with %s Clicks." % [global.endless, global.main_clicks])
	
	$scores/max_level_completed.set_text("Maximum Level Completed - %s - with %s Clicks" % [global.max_level_completed, global.successfull_clicks])
	
	$scores/total_clicks.set_text("Total Clicks Made Through the Game: %s." % [global.total_clicks])
	
	$scores/endless_mode.set_text("Endless Mode Enabled: %s." % [global.endless])
	
	$scores/help.set_text("Use handles to control water flow, try to match color of missing rectangle with the gamma.\nYou can use mouse, WASD, arrows and Esc." % [])
	
	

	$main_menu.set_text("Main Menu")

func _on_main_menu_pressed():
	get_tree().change_scene("Scenes/Main_Menu/Main_Menu.tscn")
