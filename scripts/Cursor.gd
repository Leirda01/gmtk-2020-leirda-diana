extends Node2D

func hilight(object):
	position = object.get_node("Controller").global_position
	set_visible(true)
	object.show_range()
