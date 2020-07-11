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

onready var input_list : Dictionary

func _ready():
	randomize()

func _process(_delta):
		
	if enemy_index < $Enemies.get_child_count():
		$Cursor.hilight($Enemies.get_child(enemy_index))
		for key in input_list.keys():
			if $Enemies.get_child(enemy_index) \
			.get_node("Controller") \
			.can_move(vectors[key]):
				return
			emit_signal("next_turn")
	if enemy_index == $Enemies.get_child_count():
		$Cursor.set_visible(false)
		emit_signal("attack")
		enemy_index += 1

func _input(event):
	if enemy_index < $Enemies.get_child_count():
		for key in input_list.keys():
			if event.is_action_pressed(key) \
					and $Enemies.get_child(enemy_index).move(vectors[key]):
				enemy_index += 1
				remove_from_input_list(key)
				print(input_list)


func remove_from_input_list(key: String):
	input_list[key] -= 1
	if input_list[key] == 0:
		input_list.erase(key)


static func get_random_input_list(total: int) -> Dictionary:
	var result = get_clean_input_list()
	for i in range(total):
		result[result.keys()[randi() % 4]] += 1
	for i in result.keys():
		if result[i] == 0:
			result.erase(i)
	return result

static func get_clean_input_list() -> Dictionary:
	return { "ui_right": 0, "ui_up": 0, "ui_left": 0, "ui_down": 0 }


func _on_Main_next_turn():
	$Player.random_move()
	if (score % 4 == 0):
		$Spawner.add_enemy($Enemies, Enemy.instance())
	score += 1
	input_list = get_random_input_list($Enemies.get_child_count())
	print(input_list)
	enemy_index = 0


func _on_Main_attack():
	for enemy in $Enemies.get_children():
		yield(enemy.attack(), "completed")
	emit_signal("next_turn")
