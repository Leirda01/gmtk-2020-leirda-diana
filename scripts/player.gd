extends Area2D


export var speed = 10

onready var ray = $RayCast2D
onready var tween = $Tween

var tile_size = 64
var inputs = {"right": Vector2.RIGHT,
				"left": Vector2.LEFT,
				"up": Vector2.UP,
				"down": Vector2.DOWN}

func _unhandled_input(event):
	if tween.is_active():
		return
	for direction in inputs.keys():
		if event.is_action_pressed(direction):
			move(direction)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if not ray.is_colliding():
		move_tween(dir)

func move_tween(direction):
	tween.interpolate_property(self, "position",
		position, position + inputs[direction] * tile_size,
		1.0 / speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
