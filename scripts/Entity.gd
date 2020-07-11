extends Area2D


export var speed = 15
export var tile_size = 64

onready var ray = $RayCast2D
onready var tween = $Tween

func move(direction: Vector2):
	if can_move(direction):
		smoothly_move(direction)

func can_move(direction: Vector2) -> bool:
	ray.cast_to = direction * tile_size
	ray.force_raycast_update()
	return false if ray.get_collider() else true

func smoothly_move(direction):
	tween.interpolate_property(self, "position",
		position, position + direction * tile_size, 1.0 / speed)
	tween.start()
