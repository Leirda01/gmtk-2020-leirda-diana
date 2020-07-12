extends Position2D

export(Array, Vector2) var ranges = []

func move(direction: Vector2):
	return $Controller.move(direction)


func hide_range():
	$Range.visible = false


func show_range():
	$Range.visible = true


func attack() -> Array:
	yield(get_tree(), "idle_frame")
	var colliders: = []
	for direction in ranges:
		var collider = $Controller.collider(direction)
		if collider and not collider in colliders:
			colliders.push_front(collider)
	return colliders


func jump():
	$Controller.position += 12 * Vector2.UP
	yield(get_tree().create_timer(1.0), "timeout")
	$Controller.position += 12 * Vector2.DOWN


func take_damage():
	yield(get_tree(), "idle_frame")
	for _i in range(10):
		yield(get_tree().create_timer(0.1), "timeout")
		set_visible(not visible)
	$Controller/AnimatedSprite.play("red")


func die():
	print(self, " died.")
	queue_free()
