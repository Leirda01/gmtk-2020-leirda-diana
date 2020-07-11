extends Node2D

func play_turn(object: Object):
	visible = true
	position = object.global_position
	yield(get_tree().create_timer(1.0), "timeout")
	object.move(Vector2.LEFT)
	visible = false
