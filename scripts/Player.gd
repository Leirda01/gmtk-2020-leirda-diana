extends Node2D


func random_move():
	var directions = available_directions()
	if directions:
		$Entity.move(directions[randi() % directions.size()])

func available_directions():
	var available_directions = []
	for direction in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
		if $Entity.can_move(direction):
			available_directions += [direction]
	return available_directions
