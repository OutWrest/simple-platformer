extends CanvasLayer

signal start_game

func _ready():
	restart()
	
func show_text():
	var text_group = get_node("Text")
	for label in text_group.get_children():
		label.show()
		
func hide_text():
	var text_group = get_node("Text")
	for label in text_group.get_children():
		label.hide()
	
func restart():
	$Text/Title.text = "Get To The Top!"
	show_text()
	
func start_game():
	$TitleTimer.start()
	$Background.hide()
	$StartButton.hide()
	emit_signal("start_game")

func _on_StartButton_pressed():
	start_game()

func _on_TitleTimer_timeout():
	hide_text()

func update_coins(coins):
	$CoinCounter.text = str(coins)
	
func game_over():
	$Background.show()
	$Text/Title.text = "Game Over\nDo You Want To Play Again?"
	show_text()
	$RestartButton.show()
	
func game_won():
	$Background.show()
	$Text/Title.text = "Congrats! You Won!"
	$Text/Title.show()
	$RestartButton.show()

func _on_RestartButton_pressed():
	$Text/Title.text = "Get To The Top!"
	show_text()
	$RestartButton.hide()
	start_game()
