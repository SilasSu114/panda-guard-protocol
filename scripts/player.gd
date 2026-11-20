extends CharacterBody2D

const SPEED := 260.0
const ACCEL := 2200.0
const JUMP_VELOCITY := -520.0
const GRAVITY := 1600.0

var frozen := false

func _physics_process(delta: float) -> void:
	if frozen:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var direction := 0.0
	if Input.is_action_pressed("move_left"):
		direction -= 1.0
	if Input.is_action_pressed("move_right"):
		direction += 1.0

	velocity.x = move_toward(velocity.x, direction * SPEED, ACCEL * delta)

	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_VELOCITY

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	move_and_slide()
