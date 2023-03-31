extends KinematicBody2D

const MAX_SPEED = 400

const GRAVITY   = 950
const ACCEL     = 500
const FRICTION  = 700
const JUMP      = 600

var velocity = Vector2.ZERO

onready var anim = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x, MAX_SPEED, ACCEL * delta)
		anim.play("walk")
		anim.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED, ACCEL * delta)
		anim.play("walk")
		anim.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		anim.play("idle")
		
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = -JUMP
	else:
		pass
		
	if not is_on_floor():
		anim.play("jump")
	
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func bounce():
	velocity.y = -JUMP * 0.5




