extends Node

const ranges = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]


func random_move():
	var directions = available_directions()
	if directions:
		$Controller.move(directions[randi() % directions.size()])

func available_directions():
	var available_directions: = []
	for direction in ranges:
		if $Controller.can_move(direction):
			available_directions += [direction]
	return available_directions
