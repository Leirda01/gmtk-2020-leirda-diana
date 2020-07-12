extends Node

const Enemies = [
	preload("res://scenes/enemies/Bald.tscn"),
	preload("res://scenes/enemies/Bazooka.tscn"),
	preload("res://scenes/enemies/Blond.tscn"),
	preload("res://scenes/enemies/Brown.tscn"),
	preload("res://scenes/enemies/Redhead.tscn"),
	preload("res://scenes/enemies/Shield.tscn"),
]

signal attack
signal next_turn
signal game_over

var score: = 0
var hiscore: = 0
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
				enemy_list.front().show_range(input_list.keys())
				return
		enemy_list.pop_front().hide_range()


func _input(event):
	if not enemy_list.empty():
		for key in input_list.keys():
			if event.is_action_released(key) and enemy_list.front().move(vectors[key]):
				enemy_list.pop_front().hide_range()
				$Enemies.sort()
				remove_from_input_list(key)
				$HUD.display_input(input_list)


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
	$Player.random_move()
	if (score % 2 == 0):
		$Spawners/Center.add_enemy($Enemies, Enemies[randi() % Enemies.size()].instance())
		$Spawners/Up.add_enemy($Enemies, Enemies[randi() % Enemies.size()].instance())
		$Spawners/Down.add_enemy($Enemies, Enemies[randi() % Enemies.size()].instance())
		$Spawners/Left.add_enemy($Enemies, Enemies[randi() % Enemies.size()].instance())
		$Enemies.sort()
	score += 1
	$HUD.display_score(score, hiscore)
	input_list = get_random_input_list($Enemies.get_child_count() + 1)
	$HUD.display_input(input_list)
	enemy_list = $Enemies.get_children()
	attack = not true


func _on_Main_attack():
	var grave: = []
	attack = true
	var idx = 0
	while idx < $Enemies.get_child_count():
		for entity in yield($Enemies.get_child(idx).attack(), "completed"):
			if entity.get_owner().has_method("take_damage"):
				yield($Enemies.get_child(idx).jump(
					$Enemies.get_child(idx).get_node("Controller").global_position.angle_to(entity.global_position)
				), "completed")
				grave.push_front(entity.get_owner())
				yield(entity.get_owner().call("take_damage"), "completed")
		idx += 1
	yield(get_tree().create_timer(1), "timeout")
	for dead in grave:
		dead.die()
		$Enemies.remove_child(dead)
		if dead.name == "Player":
			emit_signal("game_over")
			return
	emit_signal("next_turn")


func _on_Main_game_over():
	if score > hiscore:
		hiscore = score
	score = 0
	yield(get_tree().create_timer(3.0), "timeout")
	for enemy in $Enemies.get_children():
		enemy.queue_free()
		$Enemies.remove_child(enemy)
	$Player.initialize(Vector2(230, 134))
	emit_signal("next_turn")
