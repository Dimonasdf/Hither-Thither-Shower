extends Node2D


var hot = Color(0.0, 0.0, 0.0, 1.0)
var cold = Color(0.0, 0.0, 0.0, 1.0)
var green = Color(0.0, 0.0, 0.0, 1.0)

var gamma_start_color = Color(global.gamma_start, global.gamma_start, global.gamma_start)

var mix = Color(0.0, 0.0, 0.0, 1.0)

var color_max = 1.0
#var green_addition = 0.000

func _ready():
	
	$Flow/back_hot/color_hot.set_frame_color(hot)
	$Flow/back_cold/color_cold.set_frame_color(cold)
	$Flow/back_green_debug/color_green.set_frame_color(green)


func _process(delta):
	
	#set frames' colors based on numbers
	$Flow/back_hot/color_hot.set_frame_color(hot)
	$Flow/back_cold/color_cold.set_frame_color(cold)
	$Flow/back_green_debug/color_green.set_frame_color(green)
	
	#debug labels with numbers
	$Flow/Panel_HOT/HOT.set_text("%1.2f, %1.2f, %1.2f" % [hot.r, hot.g, hot.b])
	$Flow/Panel_COLD/COLD.set_text("%1.2f, %1.2f, %1.2f" % [cold.r, cold.g, cold.b])
	$Flow/Panel_GREEN/GREEN.set_text("%1.2f, %1.2f, %1.2f" % [green.r, green.g, green.b])
	
	# no logic, just filling extending rectangles
	$Flow/back_hot_and_cold/color_hot2.set_frame_color($Flow/back_hot/color_hot.get_frame_color())
	$Flow/back_hot_and_cold/color_cold2.set_frame_color($Flow/back_cold/color_cold.get_frame_color())
	
	
	#mixing
	#by square root
#	mix.r = sqrt(hot.r)
#	mix.g = sqrt(green.g)
#	mix.b = sqrt(cold.b)
	
	#by square
#	mix.r = hot.r*hot.r
#	mix.g = green.g*green.g
#	mix.b = cold.b*cold.b
	
	#by sum
	#uncorrect, you add alpha as well
#	mix = hot + green + cold
	
	#correct
	mix.r = hot.r
	mix.g = green.g
	mix.b = cold.b
	
	#by blend
#	mix = hot.blend(cold.blend(green))
	
	
	#set frame color
	$Flow/back_mix/color_mix.set_frame_color(mix)
	$Flow/back_mix2/color_mix2.set_frame_color(mix)
	
	
	
	#debug label
	$Flow/Panel_MIX/MIX.set_text("%1.2f, %1.2f, %1.2f, %1.2f" % [mix.r, mix.g, mix.b, mix.a])
	


func _input(event):
	if event.is_action_pressed("ui_up"):
		_on_add_hot_pressed()
	
	if event.is_action_pressed("ui_down"):
		_on_sub_hot_pressed()
	
	if event.is_action_pressed("ui_left"):
		_on_sub_cold_pressed()
	
	if event.is_action_pressed("ui_right"):
		_on_add_cold_pressed()
	


func _on_add_hot_pressed():
	randomize()

	if hot.r != color_max:
		hot = hot + Color((randf())/global.rand_mult, 0.0, 0.0, 0.0)
#		green = green + Color(0.0, green_addition, 0.0)
		global.clicks += 1
		if hot.r > color_max:
			hot.r = color_max

func _on_sub_hot_pressed():
	randomize()
	if hot.r != 0.0:
		hot = hot - Color((randf())/global.rand_mult, 0.0, 0.0, 0.0)
#		green = green - Color(0.0, green_addition, 0.0)
		global.clicks += 1
		if hot.r < 0.0:
			hot.r = 0.0


func _on_add_cold_pressed():
	randomize()

	if cold.b != color_max:
		cold = cold + Color(0.0, 0.0, (randf())/global.rand_mult, 0.0)
#		green = green + Color(0.0, green_addition, 0.0)
		global.clicks += 1
		if cold.b > color_max:
			cold.b = color_max

func _on_sub_cold_pressed():
	randomize()
	if cold.b != 0.0:
		cold = cold - Color(0.0, 0.0, (randf())/global.rand_mult, 0.0)
#		green = green - Color(0.0, green_addition, 0.0)
		global.clicks += 1
		if cold.b < 0.0:
			cold.b = 0.0


#green buttons for debug

#func _on_add_green_pressed():
#
#	if green.g != color_max:
#		green = green + Color(0.0, 0.1, 0.0)
#		if green.g > color_max:
#			green.g = color_max
#
#func _on_sub_green_pressed():
#	if green.g != 0.0:
#		green = green - Color(0.0, 0.1, 0.0)
#		if green.g < 0.0:
#			green.g = 0.0