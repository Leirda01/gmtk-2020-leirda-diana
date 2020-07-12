extends Area2D

var can_spawn: = true

func add_enemy(parent: Object, object: Object):
	if can_spawn:
		object.get_node("Controller").position = self.position
		parent.add_child(object)
		can_spawn = false


func _on_Spawner_body_exited(body):
	can_spawn = true
