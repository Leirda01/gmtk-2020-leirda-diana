extends Area2D

var can_spawn: = true

func add_enemy(parent: Object, object: Object):
	if not can_spawn:
		return
	object.position = self.position
	parent.add_child(object)
	can_spawn = false


func _on_Spawner_body_exited(body):
	can_spawn = true
