extends Control

func display_input(input: Dictionary):
	$HBox/VBox/InputContainer/right.text = "R: " + String(input["ui_right"] if input.has("ui_right") else 0)
	$HBox/VBox/InputContainer/up.text = "U: " + String(input["ui_up"] if input.has("ui_up") else 0)
	$HBox/VBox/InputContainer/left.text = "L: " + String(input["ui_left"] if input.has("ui_left") else 0)
	$HBox/VBox/InputContainer/down.text = "D: " + String(input["ui_down"] if input.has("ui_down") else 0)

func display_score(score: int, hiscore: int):
	$HBox/VBox/ScoreContainer/HighScore.text = "HS: " + str(hiscore)
	$HBox/VBox/ScoreContainer/Score.text = "score: " + str(score)
