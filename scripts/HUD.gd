extends Control

func display_input(input: Dictionary):
	$right.text = String(input["ui_right"] if input.has("ui_right") else 0)
	$up.text = String(input["ui_up"] if input.has("ui_up") else 0)
	$left.text = String(input["ui_left"] if input.has("ui_left") else 0)
	$down.text = String(input["ui_down"] if input.has("ui_down") else 0)

func display_score(score: int, hiscore: int):
	$HighScore.text = str(hiscore)
	$Score.text = str(score)
