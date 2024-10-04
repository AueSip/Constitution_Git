extends KinematicBody2D

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 650
export var ROLL_SPEED = 125
export var bullet_delay: float = 1.5

enum {
	MOVE,
	ROLL,
	ATTACK
}

var interact = null setget set_interact
var cave = null setget set_cave
var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.LEFT
var stats = PlayerStats

onready var delay = $Delay
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPiv/SwordHitbox
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer = $BlinkAnimationPlayer


func set_cave(new_cave):
	if new_cave != null:
		$Key.show()
		$KeyPrompt.play("KeyPrompt")
	else:
		$Key.hide()
		$KeyPrompt.stop()
	
	cave = new_cave

func set_interact(new_interact):
	if new_interact != null:
		$Key.show()
		$KeyPrompt.play("KeyPrompt")
	else:
		$Key.hide()
		$KeyPrompt.stop()

	interact = new_interact
		
func _unhandled_input(event):
	if event is InputEventKey and event.is_action_pressed("interact") and cave != null:
		Global.player_pos = global_position
		cave.enter()
	#If player has boss item and interacts, the signal is sent to the interact zone	
	if event is InputEventKey and event.is_action_pressed("interact") and PlayerStats.item1 == 1 and interact != null:
		interact.item1deposited()
		
func _process(delta):
	if Input.is_action_just_pressed("altattack") and delay.is_stopped():
		pass
	
func _ready():
	set_interact(null)
	set_cave(null)
	stats.connect("no_health", self , "queue_free")
	animationTree.active = true
	swordHitbox.knockback_vector = roll_vector
	
func _physics_process(delta):
		
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()  
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		swordHitbox.knockback_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity= velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move()
	
	if Input.is_action_just_pressed("roll") and $Delay.is_stopped():
		state = ROLL
		delay.start()
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	
func roll_state():
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()
	hurtbox.start_invincibility(0.3)
	
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
	 
func move():
	velocity = move_and_slide(velocity)

func roll_animation_finished():
	state = MOVE

func attack_animation_finished():
	state = MOVE


func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)
	if state == ROLL:
# warning-ignore:standalone_expression
		null
	else:
		blinkAnimationPlayer.play("Start")
	
func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")



