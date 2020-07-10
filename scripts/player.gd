extends Area2D

export var speed = 15
export var tile_size = 64

onready var ray = $RayCast2D
onready var tween = $Tween

func move(direction) -> Object:
	ray.cast_to = direction * tile_size
	ray.force_raycast_update()
	var collider = ray.get_collider()
	if collider:
		return collider
	smoothly_move(tween, direction, speed)
	return null

func smoothly_move(tween, direction, speed = 10):
	tween.interpolate_property(self, "position",
		position, position + direction * tile_size,
		1.0 / speed)
	tween.start()
