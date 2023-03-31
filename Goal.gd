extends Area2D

signal game_win

func _on_Goal_body_entered(body):
	if not body is TileMap:
		emit_signal("game_win") 
