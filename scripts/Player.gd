extends Node

const ranges = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]


func initialize(position):
	$Controller.global_position = position
	$Controller/AnimatedSprite.play("normal")

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


func take_damage():
	yield(get_tree(), "idle_frame")
	$Controller/AnimatedSprite.play("red")

func die():
	$Controller/AnimatedSprite.play("explode")
	yield($Controller/AnimatedSprite, "animation_finished")
