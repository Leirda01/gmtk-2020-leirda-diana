extends Node

func _unhandled_input(event):
	if event.is_action_pressed("ui_select"):
		$player.move(Vector2.RIGHT)
