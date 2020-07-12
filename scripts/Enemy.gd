extends Position2D


const ranges: Array = [	2 * Vector2.RIGHT,
						2 * Vector2.UP,
						2 * Vector2.LEFT,
						2 * Vector2.DOWN,
						]


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
	for direction in ranges:
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
	for _i in range(4):
		yield(get_tree().create_timer(0.5), "timeout")
		set_visible(not visible)
	self.queue_free()
