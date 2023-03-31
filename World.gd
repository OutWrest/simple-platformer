extends Node2D

var coins = 0

const CAMERA_INIT = Vector2(0.45, 0.45)
const CAMERA_INCR = Vector2(0.1, 0.1)

const TRANSITION_DURATION = 1.5

func _ready():
	for i in range(4):
		get_node("Coins/Coin" + str(i)).connect("coin_collected", self, "add_to_coins")
		
	var enemies_group = get_node("Enemies")
	for enemy in enemies_group.get_children():
		enemy.hide_enemy()
	
	$HUD.show()
	restart()
	
func restart():
	coins = 0
	$Player.hide()
	$HUD.show()
	$HUD.update_coins(coins)

func game_over():
	coins = 0
	
	$HUD.game_over()
	$HUD.update_coins(coins)

func _on_KillPlane_body_entered(body):
	game_over()
	
func game_init():
	$Player.show()
	$Player.reset_player()
	
	$Player/Camera2D.zoom = CAMERA_INIT
	
	# coins
	coins = 0
	
	var coins_group = get_node("Coins")
	for coin in coins_group.get_children():
		coin.show_coin()
		
	# enemies
	var enemies_group = get_node("Enemies")
	for enemy in enemies_group.get_children():
		enemy.show_enemy()
	
func _on_HUD_start_game():
	game_init()
	
func transition_zoom(target_zoom: Vector2, duration: float):
	$Tween.interpolate_property($Player/Camera2D, "zoom", $Player/Camera2D.zoom, target_zoom, duration,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()

func add_to_coins():
	coins += 1
	transition_zoom($Player/Camera2D.zoom + CAMERA_INCR, TRANSITION_DURATION)
	$HUD.update_coins(coins)

func _on_Player_enemy_collided():
	game_over()

func _on_Goal_game_win():
	$HUD.game_won()
