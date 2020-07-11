extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

signal attack
signal next_turn

var enemy_index : int = 0
var score = 0

const vectors = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

var input_list = {
	"ui_right": 1,
	"ui_up": 1,
	"ui_left": 1,
	"ui_down": 1,
}

func _process(_delta):
	if enemy_index < $Enemies.get_child_count():
		$Cursor.hilight($Enemies.get_child(enemy_index))
		return
	if enemy_index == $Enemies.get_child_count():
		$Cursor.set_visible(false)
		emit_signal("attack")
		enemy_index += 1

func _input(event):
	if enemy_index < $Enemies.get_child_count():
		for key in vectors.keys():
			if event.is_action_pressed(key):
				enemy_index += int($Enemies \
					.get_child(enemy_index) \
					.move(vectors[key]))

func _on_Main_next_turn():
	$Player.random_move()
	if (score % 4 == 0):
		$Spawner.add_enemy($Enemies, Enemy.instance())
	score += 1
	input_list = get_random_input_list($Enemies.get_child_count())
	enemy_index = 0


func _on_Main_attack():
	for enemy in $Enemies.get_children():
		yield(enemy.attack(), "completed")
	emit_signal("next_turn")


static func get_random_input_list(total: int):
	var result = {
		"ui_right": 0,
		"ui_up": 0,
		"ui_left": 0,
		"ui_down": 0,
	}
	for iterator in range(total):
		result[["ui_right", "ui_up", "ui_left", "ui_down"][randi() % 4]] += 1

	return result
