extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

const directions = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

func _process(_delta):
	pass

func _unhandled_input(event):
	if event.is_action_pressed("ui_select"):
		$Spawner.add_enemy($Enemies, Enemy.instance())
	for dir in directions.keys():
		if event.is_action_pressed(dir):
			$Enemies/Dummy.move(directions[dir])
			$Enemies/Enemy.move(directions[dir])
