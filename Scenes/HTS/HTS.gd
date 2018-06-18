extends Node

var color_center
var color_left
var color_right

var cold_start = Vector2(1040, -16)
var hot_start = Vector2(1056, 800)
var cold_advance = Vector2(1, 16)
var hot_advance = Vector2(0, -16)

#delta to pass to non-_process functions
#delta aggregated, to calculate an increasing value with delta
var delta_out
var delta_aggr = 0

var main_check = 'default'
var win_speed = 16
var deadly_speed = 4
var very_speed = 2
var somewhat_speed = 1

var win_calc = 0
var win_target = 1

var pause = false


func _ready():
	
	$Win_Panel.hide()
	$Lose_Panel.hide()
	$Endless_Panel.hide()
	$Escape_Panel.hide()
	
	
	
#	$Auto_Colors.get_child(global.correct).set_scale(Vector2(1.0, 2.0))
	var black = Color (0.0, 0.0, 0.0)
	$Auto_Colors.get_child(global.correct).get_child(0).set_frame_color(black)
	
	color_left = $Auto_Colors.get_child(global.correct-1).get_child(0).get_frame_color()
	color_right = $Auto_Colors.get_child(global.correct+1).get_child(0).get_frame_color()

	
	$Panel/blue_cold.set_global_position(cold_start)
	$Panel/red_hot.set_global_position(hot_start)



func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		if pause == false:
			$Escape_Panel.show()
			set_process(false)
			pause = true
		else:
			$Escape_Panel.hide()
			set_process(true)
			pause = false


func _process(delta):
	
	
	
	delta_out = delta
	main_check = 'default'
	
	$Info.set_text("Current level - %s\nClicks - %s" % [global.level, global.clicks])
	
	color_center = $tap/Flow/back_mix/color_mix.get_frame_color()
	$Auto_Colors.get_child(global.correct).get_child(0).set_frame_color(color_center)
	
	$colors1.set_text("Left.R = %.3f, Cent.R = %.3f, Right.R = %.3f." % [color_left.r, color_center.r, color_right.r])
	$colors2.set_text("Left.B = %.3f, Cent.B = %.3f, Right.B = %.3f." % [color_left.b, color_center.b, color_right.b])
	
	if $Panel/red_hot.get_global_position().y <= hot_start.y - $Panel/Control.get_size().y:
		$Lose_Panel.show()
		set_process(false)
	
	if $Panel/blue_cold.get_global_position().y >= cold_start.y + $Panel/Control.get_size().y:
		$Lose_Panel.show()
		set_process(false)
	
	$win_calc_target.set_text("%s, %s" % [win_calc, win_target])
	
	if win_calc >= win_target:
		
		
		
		if global.endless == false:
			if global.level == global.max_level:
				$Endless_Panel.show()
				global.endless = true
				set_process(false)
			else:
				$Win_Panel.show()
				set_process(false)
		else:
			$Win_Panel.show()
			set_process(false)





	if color_center.r > max(color_left.r, color_right.r):
		if color_center.b > max(color_left.b, color_right.b):
			$win.set_text("meh, too much")
			main_check = 'too_strong'

	if color_center.r < min(color_left.r, color_right.r):
		if color_center.b < min(color_left.b, color_right.b):
			$win.set_text("meh, no water")
			main_check = 'too_weak'


	if color_left.r > color_center.r and color_center.r > color_right.r:
		if color_center.b < min(color_left.b, color_right.b):
			$win.set_text("kinda hot")
			main_check = 'somewhat_hot'

		if color_center.b > max(color_left.b, color_right.b):
			$win.set_text("kinda cold")
			main_check = 'somewhat_cold'


	if color_left.b < color_center.b and color_center.b < color_right.b:
		if color_center.r > max(color_left.r, color_right.r):
			$win.set_text("somewhat hot")
			main_check = 'somewhat_hot'
		if color_center.r < min(color_left.r, color_right.r):
			$win.set_text("somewhat cold")
			main_check = 'somewhat_cold'



	if color_center.r > max(color_left.r, color_right.r):
		$win.set_text("very hot")
		if color_center.b < min(color_left.b, color_right.b):
			$win.set_text("DEADLY HOT")
			main_check = 'deadly_hot'

	if color_center.b > max(color_left.b, color_right.b):
		$win.set_text("very cold")
		if color_center.r < min(color_left.r, color_right.r):
			$win.set_text("DEADLY COLD")
			main_check = 'deadly_cold'


	if color_center.r > 0.01 and color_center.b == 0:
		$win.set_text("DEADLY HOT")
		main_check = 'deadly_hot'
	if color_center.b > 0.01 and color_center.r == 0:
		$win.set_text("DEADLY COLD")
		main_check = 'deadly_cold'



	if color_left.r > color_center.r and color_center.r > color_right.r:
		if color_left.b < color_center.b and color_center.b < color_right.b:
			$win.set_text("Perfect")
			main_check = 'perfect'


	match main_check:

		'default':
			retreat_hot(somewhat_speed)
			retreat_cold(somewhat_speed)


		'deadly_hot':
			advance_hot(deadly_speed)
			retreat_cold(very_speed)

		'deadly_cold':
			advance_cold(deadly_speed)
			retreat_hot(very_speed)

		'very_hot':
			advance_hot(very_speed)

		'very_cold':
			advance_cold(very_speed)

		'somewhat_hot':
			advance_hot(somewhat_speed)

		'somewhat_cold':
			advance_cold(somewhat_speed)

		'too_weak':
			retreat_hot(somewhat_speed)
			retreat_cold(somewhat_speed)
			if win_calc > 0:
				win_calc = win_calc - delta*deadly_speed

		'too_strong':
			advance_hot(somewhat_speed)
			advance_cold(somewhat_speed)
			if win_calc > 0:
				win_calc = win_calc - delta*deadly_speed

		'perfect':
			retreat_hot(win_speed)
			retreat_cold(win_speed)
			win_calc = win_calc + delta*deadly_speed


func advance_hot(speed):
	$Panel/red_hot.set_global_position($Panel/red_hot.get_global_position() + hot_advance*delta_out*speed)
	$Panel/red_hot.set_rotation($Panel/red_hot.get_rotation() + delta_out*1.3)

func advance_cold(speed):
	delta_aggr = delta_aggr + delta_out
	var cold_advance_2 = Vector2($Panel/blue_cold.get_global_position().x + cold_advance.x*sin(delta_aggr*4), $Panel/blue_cold.get_global_position().y + cold_advance.y*delta_out*speed)
	$Panel/blue_cold.set_global_position(cold_advance_2)

func retreat_hot(speed):
	if $Panel/red_hot.get_global_position().y < hot_start.y:
		$Panel/red_hot.set_global_position($Panel/red_hot.get_global_position() - hot_advance*delta_out*speed)

func retreat_cold(speed):
	if $Panel/blue_cold.get_global_position().y > cold_start.y:
		$Panel/blue_cold.set_global_position($Panel/blue_cold.get_global_position() - cold_advance*delta_out*speed)


func successfull_end():
	
	global.successfull_clicks = global.successfull_clicks + global.clicks
	global.total_clicks = global.total_clicks + global.clicks
	global.clicks = 0
	
	global.level += 1
	global.quantity = 6.0 + 2*global.level
	
	if global.level -1 > global.max_level_completed:
		global.max_level_completed = global.level -1



func _on_next_level_pressed():
	
	successfull_end()
	
	get_tree().change_scene("Scenes/HTS/HTS.tscn")



func _on_endless_pressed():
	
	successfull_end()
	global.main_clicks = global.successfull_clicks
	
	get_tree().change_scene("Scenes/HTS/HTS.tscn")


func _on_main_menu_endless_pressed():
	
	successfull_end()
	
	global.to_continue = true
	global.to_continue_level = global.level
	
	global.main_clicks = global.successfull_clicks
	
	get_tree().change_scene("Scenes/Main_Menu/Main_Menu.tscn")


func _on_main_menu_pressed():
	
	global.to_continue = true
	global.to_continue_level = global.level
	
	global.total_clicks = global.total_clicks + global.clicks
	get_tree().change_scene("Scenes/Main_Menu/Main_Menu.tscn")




func _on_main_menu_lost_pressed():
	
	global.to_continue = false
	global.total_clicks = global.total_clicks + global.clicks
	get_tree().change_scene("Scenes/Main_Menu/Main_Menu.tscn")