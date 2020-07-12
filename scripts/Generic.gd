extends Position2D

export(Array, Vector2) var ranges = []
export(int) var speed = 1

func move(direction: Vector2):
	$Controller/AnimatedSprite.flip_h = true if direction.x < 0 else false
	if not $Controller.move(speed * direction):
		return $Controller.move(direction)
	return true


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


func jump(direction: float):
	#$Controller.position += 12 * Vector2.UP
	animate_attack(direction)
	yield(get_tree().create_timer(1.0), "timeout")
	#$Controller.position += 12 * Vector2.DOWN


func take_damage():
	yield(get_tree(), "idle_frame")
	for _i in range(10):
		yield(get_tree().create_timer(0.1), "timeout")
		set_visible(not visible)
	$Controller/AnimatedSprite.play("red")


func animate_attack(direction: float):
	$Controller/Effect/Attack.rotation_degrees = rad2deg(direction)
	print($Controller/Effect/Attack.rotation_degrees)
	$Controller/Effect/Attack.set_visible(true)
	$Controller/Effect/Attack.play("default")
	yield($Controller/Effect/Attack, "animation_finished")
	$Controller/Effect/Attack.set_visible(false)

func die():
	queue_free()
