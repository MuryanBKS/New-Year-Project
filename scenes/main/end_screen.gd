extends CenterContainer


func update_score(score: int):
	%Label.text = str(score)
	$AnimationPlayer.play("congratulation")
