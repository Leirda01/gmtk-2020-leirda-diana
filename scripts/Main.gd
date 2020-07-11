extends Node

const Enemy = preload("res://scenes/Enemy.tscn")

const directions = {
	"ui_right": Vector2.RIGHT,
	"ui_up": Vector2.UP,
	"ui_left": Vector2.LEFT,
	"ui_down": Vector2.DOWN,
}

func _process(_delta):
	pass
	# si tout les ennemis n’ont pas bougé:
	# 	positionner le curseur
	# 	return
	# dis au programme de s’occuper des attaques
	# bouge le joueur

func _input(event):
	pass
	# si il reste des ennemis qui n’ont pas bougé
	# 	si une touche de la liste est pressée
	# 		si ce n’est pas une touche valide
	# 			return
	# 		l’ennemi.move(la direction de la touche)
