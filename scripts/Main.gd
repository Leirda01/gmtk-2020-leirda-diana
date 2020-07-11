extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

const directions = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

func _ready():
	play()

func play():
	for enemy in $Enemies.get_children():
		yield($Cursor.play_turn(enemy), "completed")
