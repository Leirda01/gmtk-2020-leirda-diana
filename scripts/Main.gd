extends Node

const directions = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

func _unhandled_input(event):
	if event.is_action_pressed("ui_select"):
		$Player.random_move()
	for dir in directions.keys():
		if event.is_action_pressed(dir):
			$Enemy.move(directions[dir])
