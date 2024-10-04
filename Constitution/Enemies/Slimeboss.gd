extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const HitSoundEffect = preload("res://Enemies/HurtSound.tscn")
const Item1 = preload("res://Interactables/Item1.tscn")
var velocity = Vector2.ZERO
export var ACCELERATION = 500
export var MAX_SPEED = 125
export var FRICTION = 200


onready var rockSpawn = $RockSpawn
onready var bossMusic = $Boss1Music
onready var stats = $Stats
onready var sprite = $Sprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var animationTree = $AnimationTree
onready var activeZone = $ActiveZone
onready var bossHp = $ActiveZone/CollisionShape2D/CanvasLayer/BossBar

func _process(delta):
	bossHp.value = stats.health

func _physics_process(delta):
	var player = playerDetectionZone.player
	if player != null:
		accelerate_towards_point(player.global_position, delta)
	velocity = move_and_slide(velocity)
	if player == null:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()
	var hitSoundEffect = HitSoundEffect.instance()
	get_tree().current_scene.add_child(hitSoundEffect)
	

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
	var item1 = Item1.instance()
	get_parent().add_child(item1)
	item1.global_position = global_position

func accelerate_towards_point(point, delta):
	var direction = self.global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0


func _on_ActiveZone_body_entered(body):
	var player = body
	if player != null:
		animationTree.active = true
		bossHp.visible = true
		bossMusic.play()
		print ("Im Playing")
