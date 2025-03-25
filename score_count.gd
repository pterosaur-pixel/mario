extends Label

func _process(_delta: float) -> void:
	var score = Score.score
	if score < 10:
		text = '00000'+str(score)
	elif score < 100:
		text = '0000'+str(score)
	elif score < 1000:
		text = '000'+str(score)
	elif score <10000:
		text = '00' + str(score)
	elif score < 100000:
		text = '0'+str(score)
	else:
		text = str(score)
