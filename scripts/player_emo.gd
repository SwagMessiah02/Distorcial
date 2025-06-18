extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	velocity.x = Input.action_press("ui_left", "ui_rigth", "ui_up", "ui_down")

	move_and_slide()
