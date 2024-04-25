extends CharacterBody2D


const SPEED = 15.0
const JUMP_VELOCITY = -500.0
const MAX_JUMPS = 2
var jumpcounter = 0
var jumpcd = false
var played_sound = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var label = $Label
@onready var label2 = $Label2
@onready var anim = $anim
@onready var trap = $"../Traps/Spike/Trap/AnimatedSprite2D"

func _physics_process(delta):
	# Air resistance
	velocity.x -= (velocity.x*delta)
	if abs(velocity.x) < (SPEED*0.95):
		velocity.x = 0
	if is_on_floor():
		jumpcounter = 0
		if !played_sound:
			$Land.play()
			played_sound = true
	if is_on_floor():
		if velocity.x > 0:
			anim.flip_h = false
			anim.animation = "right"
		elif velocity.x < 0:
			anim.flip_h = true
			anim.animation = "right"
		else:
			anim.animation = "idle"
	else:
		anim.animation = "air"
	anim.play()
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumpcounter < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumpcounter += 1
		Global.totaljump += 1
		var new = "Jumps: " + str(Global.totaljump)
		label.text=new
		if jumpcounter == 1:
			played_sound = false
			$"Jump 1".play()
		else:
			played_sound = false
			$"Jump 2".play()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions
	
	elif Input.is_action_just_pressed("ui_select") and jumpcounter < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumpcounter += 1
		Global.totaljump += 1
		var new = "Jumps: " + str(Global.totaljump)
		label.text=new
		if jumpcounter == 1:
			played_sound = false
			$"Jump 1".play()
		else:
			played_sound = false
			$"Jump 2".play()
	
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
	move_and_slide()
	
	var stuff = "Coins: " + str(Global.coin_count)
	label2.text = stuff
	
	if Global.hp < 1.0:
		anim.animation = "dead"
		$Death.play()


func _on_trap_body_entered(body):
	if body.name == "Player":
		Global.hp = 0.0
		await get_tree().create_timer(1).timeout
		Global.hp += 1.0
		get_tree().change_scene_to_file("res://dead_screen.tscn")



func _on_void_body_entered(body):
	if body.name == "Player":
		Global.hp = 0.0
		await get_tree().create_timer(1).timeout
		Global.hp += 1.0
		get_tree().change_scene_to_file("res://dead_screen.tscn")


func _on_win_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://win_screen.tscn")
