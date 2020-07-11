extends Node2D

var last_object: Object

func hilight(object):
	last_object = object
	position = object.get_node("Controller").global_position
	set_visible(true)
	object.show_range()

func hide():
	if last_object:
		last_object.hide_range()
	set_visible(false)
