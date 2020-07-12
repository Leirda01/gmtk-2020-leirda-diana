extends StaticBody2D


export var speed = 15
export var tile_size = 24

onready var ray = $RayCast2D
onready var tween = $Tween


func move(direction: Vector2) -> bool:
	if can_move(direction):
		 return smoothly_move(direction)
	return false


func can_move(direction: Vector2) -> bool:
	ray.cast_to = direction * tile_size
	ray.force_raycast_update()

	var collider = ray.get_collider()
	if not collider:
		return true
	if collider.global_position == global_position:
		ray.add_exception(collider)
		if can_move(direction):
			ray.clear_exceptions()
			return true
		ray.clear_exceptions()
	return false


func collider(direction: Vector2) -> Object:
	ray.cast_to = direction * tile_size
	ray.force_raycast_update()
	return ray.get_collider()


func smoothly_move(direction):
	if tween.is_active():
		return false
	tween.interpolate_property(self, "position",
		position, position + direction * tile_size, 1.0 / speed)
	tween.start()
	return true


func show_available_directions(dirs: Array):
	for dir in dirs:
		match dir:
			"ui_right":
				if self.can_move(Vector2.LEFT):
					$Right.set_visible(true)
					continue
			"ui_up":
				if self.can_move(Vector2.UP):
					$Up.set_visible(true)
					continue
			"ui_left":
				if self.can_move(Vector2.LEFT):
					$Left.set_visible(true)
					continue
			"ui_down":
				if self.can_move(Vector2.DOWN):
					$Down.set_visible(true)
					continue


func hide_directions():
	$Right.set_visible(false)
	$Up.set_visible(false)
	$Left.set_visible(false)
	$Down.set_visible(false)
