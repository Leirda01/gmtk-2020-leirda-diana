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
	print("pausing...")
	yield(get_tree().create_timer(1.0), "timeout")
	print("resumed!")

func die():
	pass
