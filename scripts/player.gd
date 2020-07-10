extends Area2D

onready var ray = $RayCast2D

var tile_size = 64
var inputs = {"right": Vector2.RIGHT,
				"left": Vector2.LEFT,
				"up": Vector2.UP,
				"down": Vector2.DOWN}
#
#func _ready():
#	position = position.snapped(Vector2.ONE * tile_size)
#	position += Vector2.ONE * tile_size

func _unhandled_input(event):
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if not ray.is_colliding():
		position += inputs[dir] * tile_size
