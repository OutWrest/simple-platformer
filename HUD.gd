extends CanvasLayer

signal start_game

func _ready():
	restart()
	
func restart():
	$Title.text = "Get To The Top!"
	$Title.show()

func _on_StartButton_pressed():
	$TitleTimer.start()
	$Background.hide()
	$StartButton.hide()
	emit_signal("start_game")

func _on_TitleTimer_timeout():
	$Title.hide()

func update_coins(coins):
	$CoinCounter.text = str(coins)
	
func game_over():
	$Background.show()
	$Title.text = "Game Over"
	$Title.show()
