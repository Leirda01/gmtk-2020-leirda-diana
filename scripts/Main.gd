extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

var enemy_index : int = 0

const directions = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

func _process(_delta):
	if enemy_index < $Enemies.get_child_count():
		$Cursor.position = $Enemies.get_child(enemy_index).position
		return
	# dis à la machine de calculer les attaques ici
	$Player.random_move()
	$Spawner.add_enemy($Enemies, Enemy.instance())
	enemy_index = 0

func _input(event):
	if enemy_index <= $Enemies.get_child_count():
		for key in directions.keys():
			if event.is_action_pressed(key):
				enemy_index += int($Enemies \
					.get_child(enemy_index) \
					.get_node("Controller") \
					.move(directions[key]))
