extends Node

const Entity = preload("res://scenes/Entity.tscn")

func _ready():
	var enemy = Entity.instance().set_texture("res://sprites/enemy-1.png")
	add_child(enemy)

func _unhandled_input(event):
	if event.is_action_pressed("ui_select"):
		$player.move(Vector2.RIGHT)
