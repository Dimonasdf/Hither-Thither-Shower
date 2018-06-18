extends Node2D

var one = Vector2(1, 1)

func _ready():
	
	pass

func _process(delta):
	
	$Panel/location.set_text("%.0f, %.0f" % [get_global_position().x, get_global_position().y])
	$Panel2/color.set_text("%1.2f, %1.2f, %1.2f" % [$ColorRect.get_frame_color().r, $ColorRect.get_frame_color().g, $ColorRect.get_frame_color().b])
	$Panel/location.set_scale(one)
	$Panel2/color.set_scale(one)