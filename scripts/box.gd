extends CharacterBody2D

const GRAVITY := 1600.0
const PUSH_SPEED := 180.0
const PUSH_ACCEL := 1600.0

var push_velocity := 0.0

func _physics_process(delta: float) -> void:
	var target_velocity := push_velocity
	push_velocity = 0.0

	if not is_on_floor():
		velocity.y += GRAVITY * delta

	velocity.x = move_toward(velocity.x, target_velocity, PUSH_ACCEL * delta)
	move_and_slide()

	if is_on_floor():
		velocity.y = 0.0

func push(direction: float) -> void:
	push_velocity = direction * PUSH_SPEED
