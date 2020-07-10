extends Area2D

export var speed = 15
export var tile_size = 64

onready var ray = $RayCast2D
onready var tween = $Tween

func set_texture(texture: Texture):
	$Sprite.set_texture(texture)

func move(direction):
	ray.cast_to = direction * tile_size
	ray.force_raycast_update()
	var collider = ray.get_collider()
	if collider:
		return collider
	smoothly_move(direction)

func smoothly_move(direction):
	tween.interpolate_property(self, "position",
		position, position + direction * tile_size, 1.0 / speed)
	tween.start()
