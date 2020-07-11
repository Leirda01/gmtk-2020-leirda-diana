extends Area2D


func add_enemy(parent: Object, object: Object):
	object.position = self.position
	parent.add_child(object)
