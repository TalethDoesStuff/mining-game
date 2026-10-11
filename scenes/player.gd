extends CharacterBody2D

@export var debug: bool = false



@export_category("Physics")
@export_group("Movement")
@export var max_speed: float = 150.0
@export var acceleration: float = 18.0
@export var friction: float = 12.0

@export_group("Jump")
@export var jump_height: float = 64.0
@export var coyote_time: int = 2
var _coyote_time


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		var gravity = get_gravity().y
		var jump_force = -sqrt(2.0 * jump_height * gravity)
		velocity.y = jump_force

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x += direction * acceleration
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
	velocity.x = clampf(velocity.x, -max_speed, max_speed)

	move_and_slide()
