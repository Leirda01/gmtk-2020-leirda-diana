extends Area2D


func add_enemy(parent: Object, object: Object):
	object.get_node("Controller").position = self.position
	parent.add_child(object)
