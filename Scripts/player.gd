extends CharacterBody2D
class_name Player

@export var speed = 165
@export var gravity = 15
@export var jump_force = 250

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D
@onready var ray1 = $RayCast2D
@onready var ray2 = $RayCast2D2
@onready var jump = $AudioStreamPlayer2D
@onready var death = $AudioStreamPlayer2D2
@onready var wallstep = $AudioStreamPlayer2D3
@onready var time_label = $TimeLabel

var is_crouching = false
var stuck_under = false
var double_jump = false

var game_time = 0.0
var start_game_msec = 0.0

var standing_cshape = preload("res://Resources/pstanding.tres")
var crouching_cshape = preload("res://Resources/pcrouching.tres")

func _ready():
	Gamemanager.player = self
	start_game_msec = Time.get_ticks_msec()

func _process(delta):
	game_time = Time.get_ticks_msec() - start_game_msec
	time_label.text = str(game_time / 1000.0)

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 700:
			velocity.y = 700
	
	if is_on_wall() and velocity.y > 0:
		gravity = 5
	else:
		gravity = 15
	
	if is_on_floor(): double_jump = true
	if Input.is_action_just_pressed("jump") && is_on_floor():
		jump.play()
		velocity.y = -jump_force
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and double_jump and not is_on_wall():
			jump.play()
			velocity.y = -jump_force
			double_jump = false
	
	var horizontal_direction = Input.get_axis("move_left","move_right")
	velocity.x = speed * horizontal_direction
	
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
		
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		if above_clear():
			stand()
		else:
			if stuck_under != true:
				stuck_under = true
	
	if stuck_under && above_clear():
		stand()
		stuck_under = false
	
	wall_jump()
	move_and_slide()
	update_animations(horizontal_direction)
	
func above_clear():
	var result = !ray1.is_colliding() && !ray2.is_colliding()
	return result
	
func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			if is_crouching:
				ap.play("crouch")
			else:
				ap.play("idle")
		else:
			if is_crouching:
				ap.play("crouch_walk")
			else:
				ap.play("run")
	else:
		if is_crouching == false:
			if velocity.y < 0:
				ap.play("jump")
			elif velocity.y > 0:
				if is_on_wall():
					ap.play("wall_slide")
					sprite.position.x = horizontal_direction * -4
				elif not is_on_floor():
					ap.play("fall")
					sprite.position.x = horizontal_direction * 4
				else:
					sprite.position.x = horizontal_direction * 4
		else:
			ap.play("crouch")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4

func wall_jump():
	if not is_on_wall(): return
	var wall_normal = get_wall_normal()
	if is_on_wall() and Input.is_action_pressed("move_right") and Input.is_action_just_pressed("jump"):
		wallstep.play()
		velocity.x += -speed + jump_force
		velocity.y = -jump_force
	if Input.is_action_just_pressed("jump") and is_on_wall() and Input.is_action_pressed("move_left"):
		wallstep.play()
		velocity.x += speed + jump_force
		velocity.y = -jump_force


func crouch():
	if is_crouching:
		return
	is_crouching = true
	speed = 100
	cshape.shape = crouching_cshape
	cshape.position.y = 51

func stand():
	if is_crouching == false:
		return
	is_crouching = false
	speed = 165
	cshape.shape = standing_cshape
	cshape.position.y = 45.5

func die():
	Gamemanager.respawn_Player()
	death.play()

