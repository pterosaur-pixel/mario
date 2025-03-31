extends Label
func _process(_delta: float) -> void:
	if CoinCount.coin_count == 100:
		CoinCount.coin_count = 0
		MarioLives.lives += 1
	if CoinCount.coin_count < 10:	
		text = "0" + str(CoinCount.coin_count)
	elif CoinCount.coin_count >= 10:
		text = str(CoinCount.coin_count)
	
