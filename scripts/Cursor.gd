extends Node2D

func hilight(object):
	position = object.get_node("Controller").global_position
	object.show_range()
