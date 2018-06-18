extends Node



#difficulty
#quantity of values
var new_level = 1
var level = 1
var max_level = 10
var quantity

var endless = false
var to_continue = false

var to_continue_level = 1

#which one will be correct
var correct

#random value of clicks
#every click is (0->1)/rand_mult
var rand_mult = 10.0 #less - harder


#how bright will colors be
var gamma_start = float(0.0) #more - brighter
var gamma_end = float(0.8) #less - darker


#our score, the less - the better
var clicks = 0
var main_clicks = 0
var successfull_clicks = 0
var total_clicks = 0

var max_level_completed = 0

func _ready():
	
	if level < new_level:
		level = new_level
	quantity = 6.0 + 2*level