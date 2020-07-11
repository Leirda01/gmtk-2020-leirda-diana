extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

signal attack
signal next_turn

var score: = 0
var attack: = false

const vectors = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

onready var enemy_list: = $Enemies.get_children()
onready var input_list: Dictionary

func _ready():
	randomize()

func _process(_delta):
	if attack:
		return
	if enemy_list.empty():
		emit_signal("attack")
	else:
		for key in input_list.keys():
			if enemy_list.front().get_node("Controller").can_move(vectors[key]):
				$Cursor.hilight(enemy_list.front())
				return
		print("SKIP")
		$Cursor.hide()
		enemy_list.pop_front()

func _input(event):
	if not enemy_list.empty():
		for key in input_list.keys():
			if event.is_action_released(key) \
					and enemy_list.front().move(vectors[key]):
				enemy_list.pop_front()
				remove_from_input_list(key)
				statusline()


func remove_from_input_list(key: String):
	input_list[key] -= 1
	if input_list[key] == 0:
		input_list.erase(key)


static func get_random_input_list(total: int) -> Dictionary:
	var result = get_clean_input_list()
	for _i in range(total):
		result[result.keys()[randi() % 4]] += 1
	for i in result.keys():
		if result[i] == 0:
			result.erase(i)
	return result

static func get_clean_input_list() -> Dictionary:
	return { "ui_right": 0, "ui_up": 0, "ui_left": 0, "ui_down": 0 }


func _on_Main_next_turn():
	$Cursor.hide()
	$Player.random_move()
	if (score % 4 == 0):
		$Spawner.add_enemy($Enemies, Enemy.instance())
	score += 1
	input_list = get_random_input_list($Enemies.get_child_count() + 1)
	statusline()
	enemy_list = $Enemies.get_children()


func _on_Main_attack():
	attack = true
	for enemy in $Enemies.get_children():
		yield(enemy.attack(), "completed")
	emit_signal("next_turn")
	attack = not true

func statusline():
	print("turn: " + String(score) + " input: " + String(input_list))
