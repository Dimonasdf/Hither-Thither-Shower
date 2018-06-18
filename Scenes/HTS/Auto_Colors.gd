extends Control


func _ready():

	var scene = load("res://Scenes/Gamma_Rect/gamma_rect.tscn")
	var scale_x = float(416.0/global.quantity/32.0)
	var scale_y = float(1.0)
	print(scale_x)
	print(scale_y)
	var scale = Vector2(scale_x, scale_y)

	for i in range(global.quantity):
		var rect = scene.instance()
		add_child(rect)
		get_child(i).set_global_position(Vector2(128 + 416/global.quantity*i, 496))
		
		get_child(i).get_child(0).set_scale(scale)
#		get_child(i).get_child(1).set_scale(scale)
		get_child(i).get_child(0).set_frame_color(next_gamma_color(i, global.quantity))
#		get_child(i).get_child(1).set_frame_color(next_gamma_color(i, global.quantity))

	randomize()
	var correct = randi() % (int(global.quantity)-4) + 2
	global.correct = correct
	
func next_gamma_color(index, q):
	
	#0 to q, from red to blue
	var step = (global.gamma_end - global.gamma_start) / (q - 1)
	return Color(global.gamma_end - index*step, global.gamma_start, global.gamma_start + index*step)
	pass

#func _process(delta):

#	pass
