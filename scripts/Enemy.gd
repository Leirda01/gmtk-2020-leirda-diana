extends Node2D

func move(direction: Vector2):
	hide_range()
	return $Controller.move(direction)

func show_range():
	$Range.visible = true

func hide_range():
	$Range.visible = false

func attack():
	pass

func die():
	pass
