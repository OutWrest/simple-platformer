extends Node2D

var coins = 0

func _ready():
	for i in range(2):
		get_node("Coins/Coin" + str(i)).connect("coin_collected", self, "add_to_coins")
	
	$HUD.show()
	restart()
	
func restart():
	coins = 0
	$Player.hide()
	$HUD.show()
	$HUD.update_coins(coins)

func game_over():
	$Player.hide()
	$Hud.game_over()

func _on_KillPlane_body_entered(body):
	game_over()
	

func _on_HUD_start_game():
	$Player.show()

func add_to_coins():
	coins += 1
	$HUD.update_coins(coins)

