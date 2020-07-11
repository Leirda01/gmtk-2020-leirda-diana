extends Node2D


signal has_attacked

func move(direction: Vector2):
	hide_range()
	return $Controller.move(direction)

func show_range():
	$Range.visible = true

func hide_range():
	$Range.visible = false

func attack():
	yield(get_tree(), "idle_frame")
	var colliders = remove_item($Controller, $Range.get_overlapping_areas())
	for collider in colliders:
		if collider.has_method("die"):
			collider.die()
			return

static func remove_item(item, list: Array):
	var result := []
	for element in list:
		if not element == item:
			result += [element]
	return result
