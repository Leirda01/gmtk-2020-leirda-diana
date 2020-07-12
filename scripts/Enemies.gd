extends Node

func sort():
	var sorted = get_children()
	sorted.sort_custom(self, "compare_by_Y")
	for i in range(get_child_count()):
		move_child(sorted[i], i)

func compare_by_Y(a, b):
	return a.get_node("Controller").position.y < b.get_node("Controller").position.y
