extends KinematicBody2D

var score : int = 0
var initialSpeed : int = 300

var speed : int = initialSpeed
var jumpForce : int = 600
var gravity : int = 1300

var vel : Vector2 = Vector2()

onready var sprite : Sprite = get_node("Sprite")

func _physics_process(delta):
	vel.x = 0
	
	# running
	if Input.is_action_pressed("run"):
		speed = initialSpeed + 200
	else:
		speed = initialSpeed
		
	# idle animation
	if is_on_floor() and !Input.is_action_pressed("move_left") and !Input.is_action_pressed("move_right"): 
		$AnimationPlayer.play("idle")

	# movements
	if Input.is_action_pressed("move_left"):
		if is_on_floor():
			$AnimationPlayer.play("walk")
		vel.x -= speed
	if Input.is_action_pressed("move_right"):
		if is_on_floor():
			$AnimationPlayer.play("walk")
		vel.x += speed

	# velocity
	vel = move_and_slide(vel, Vector2.UP)
	
	# gravity
	vel.y += gravity * delta
	
	# jump action
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
		
	# jump animation
	if !is_on_floor():
		if vel.y < 100:
			$AnimationPlayer.play("fall")
		else:
			$AnimationPlayer.play("jump")
	
	# sprite direction
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false
