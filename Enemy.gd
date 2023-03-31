extends KinematicBody2D

var velocity = Vector2()
const GRAVITY = 40
var speed = 50
export var direction = -1
export var detects_cliffs = true

const DEATH_TIMER_LIMIT = 20
var death_timer_current = 0

var current_scale

func _ready():
	$AnimatedSprite.flip_h = direction > 0
	$FloorDetector.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$FloorDetector.enabled = detects_cliffs
	
func _physics_process(delta):
	velocity.y += GRAVITY
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)

	if is_on_wall() or (not $FloorDetector.is_colliding() and detects_cliffs and is_on_floor()):
		direction *= -1
		$AnimatedSprite.flip_h = direction > 0
		$FloorDetector.position.x = $CollisionShape2D.shape.get_extents().x * direction

func _on_Hurtbox_body_entered(body):
	$AnimatedSprite.play("squish")
	speed = 0

	set_collision_layer_bit(2, false)
	set_collision_mask_bit(0, false)
	
	body.bounce()
	
	$DeathTimer.start()

func _on_DeathTimer_timeout():
	death_timer_current += 1
	
	current_scale = transform.get_scale()
	
	current_scale *= (DEATH_TIMER_LIMIT-death_timer_current)/death_timer_current 
	
	transform.scaled(current_scale)

	
	if death_timer_current > DEATH_TIMER_LIMIT:
		queue_free()
	else:
		$DeathTimer.start()
