extends Area2D


export var speed = 15
export var tile_size = 24

onready var ray = $RayCast2D
onready var tween = $Tween

func move(direction: Vector2) -> bool:
	if can_move(direction):
		smoothly_move(direction)
		return true
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

func smoothly_move(direction):
	if tween.is_active():
		return
	tween.interpolate_property(self, "position",
		position, position + direction * tile_size, 1.0 / speed)
	tween.start()
