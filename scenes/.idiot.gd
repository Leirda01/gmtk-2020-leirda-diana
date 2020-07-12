extends Node

func hide_range():
	pass

func attack():
	yield(get_tree(), "idle_frame")
	return []

func can_move(a):
	pass
