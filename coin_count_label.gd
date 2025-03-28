extends Label
func _process(_delta: float) -> void:
	if CoinCount.coin_count > 100:
		CoinCount.coin_count = "0"
	text = str(CoinCount.coin_count)
	
