extends Position2D


func move(direction: Vector2):
	return $Controller.move(direction)

func hide_range():
	$Range.visible = false

func show_range():
	$Range.visible = true

func attack() -> Array:
	yield(get_tree(), "idle_frame")
	var colliders: = []
	yield(jump(), "completed")
	for direction in $Range.ranges:
		var collider = $Controller.collider(direction)
		if collider:
			colliders.push_front(collider)
	return colliders


func jump():
	$Controller.position += 12 * Vector2.UP
	yield(get_tree().create_timer(1.0), "timeout")
	$Controller.position += 12 * Vector2.DOWN

func die():
	print(self.name, ": ouch!")
	yield(get_tree(), "idle_frame")
	for _i in range(10):
		yield(get_tree().create_timer(0.1), "timeout")
		set_visible(not visible)
	$Controller/AnimatedSprite.play("red")
