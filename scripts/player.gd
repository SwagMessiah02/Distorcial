extends CharacterBody2D
		 
@export var ghost_node : PackedScene
@onready var ghost_timer = $Timer

const SPEED = 700.0
const GRAVITY = 500.0
const JUMP_VELOCITY = -590
const DASH_SPEED = 1000.0
const SLIDE_TIME = 0.4
const FALL_GRAVITY = 6000

var is_dashing = false
var can_dash = true
var is_sliding = false

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.position = position
	ghost.scale = scale
	get_tree().current_scene.add_child(ghost)
  
func get_grav(vel: Vector2):
	if vel.y < 0:
		return GRAVITY 
	return FALL_GRAVITY

func _process(delta: float) -> void:
	print(velocity.y)
	if is_dashing and is_on_floor() and not can_dash:
		is_dashing = false
		can_dash = true
		
	if not is_on_floor():
		velocity.y += get_grav(velocity) * delta * 1.5

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("dash") and not is_dashing and not is_on_floor() and can_dash:
		is_dashing = true
		can_dash = false
		velocity.x = DASH_SPEED 
		
	#if Input.is_action_just_pressed("slide") and is_on_floor() and not is_sliding:
	#	is_sliding = true
	#	slide_timer = SLIDE_TIME
	#	velocity.x = SLIDE_SPEED

	#if is_sliding:
	#	slide_timer -= delta
	#	if slide_timer <= 0:
	#		is_sliding = false

	if not is_dashing: # and not is_sliding:
		velocity.x = SPEED

	move_and_slide()		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().reload_current_scene()

func _on_timer_timeout() -> void:
	if is_dashing:
		add_ghost() 
