extends CharacterBody3D

const LOOK_SENSITIVITY = 0.0025
const LOOK_LIMIT_UPPER = 1.15
const LOOK_LIMIT_LOWER = -1.15
const MOVE_SPEED = 4.5
const ROTATE_SPEED = 15.0
const JUMP_FORCE = 15.0
const GRAVITY_FORCE = 50.0
const TOGGLE_COOLDOWN = 0.5

var move_direction = Vector3.ZERO
var move_direction_no_y = Vector3.ZERO
var camera_rotation = Quaternion.IDENTITY
var camera_rotation_no_y = Quaternion.IDENTITY
var noclip_on = false
var noclip_toggle_cooldown = 0.0
var mousecapture_on = false
var mousecapture_toggle_cooldown = 0.0

var mouse_movement = Vector2.ZERO
var forward_isdown = false
var backward_isdown = false
var left_isdown = false
var right_isdown = false
var noclip_isdown = false
var sprint_isdown = false
var jump_isdown = false
var mousecapture_isdown = false

func _ready():
	basis = Basis.IDENTITY

func _process(delta):
	process_mousecapture(delta)
	process_camera()
	process_movement()
	process_animation(delta)
	process_noclip(delta)
	
	var move_speed = MOVE_SPEED
	if sprint_isdown:
		move_speed = MOVE_SPEED * 2
	
	if noclip_on:
		velocity = move_direction * (move_speed * 3)
	else:
		velocity.x = move_direction_no_y.x * move_speed 
		velocity.z = move_direction_no_y.z * move_speed
		if not is_on_floor():
			velocity.y -= GRAVITY_FORCE * delta
		if jump_isdown and is_on_floor():
			velocity.y = JUMP_FORCE
	
	move_and_slide()

func process_mousecapture(delta):
	if mousecapture_isdown and mousecapture_toggle_cooldown == 0:
		mousecapture_on = !mousecapture_on
		mousecapture_toggle_cooldown = TOGGLE_COOLDOWN
	
	if mousecapture_on:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	mousecapture_toggle_cooldown -= delta
	mousecapture_toggle_cooldown = clamp(mousecapture_toggle_cooldown, 0, TOGGLE_COOLDOWN)

func process_camera():
	var camera_rotation_euler = camera_rotation.get_euler()
	
	if mousecapture_on:
		camera_rotation_euler += Vector3(mouse_movement.y, mouse_movement.x, 0) * LOOK_SENSITIVITY
		camera_rotation_euler.x = clamp(camera_rotation_euler.x, LOOK_LIMIT_LOWER, LOOK_LIMIT_UPPER)
	
	camera_rotation = Quaternion.from_euler(camera_rotation_euler)
	$CameraPivot.basis = Basis(camera_rotation)
	camera_rotation_no_y = Basis($CameraPivot.basis.x, Vector3.UP, $CameraPivot.basis.z).get_rotation_quaternion()
	
	mouse_movement = Vector2.ZERO

func process_movement():
	var input_direction = Vector3.ZERO
	
	if forward_isdown:
		input_direction.z -= 1.0
	if backward_isdown:
		input_direction.z += 1.0
	if left_isdown:
		input_direction.x -= 1.0
	if right_isdown:
		input_direction.x += 1.0
	
	move_direction = camera_rotation * input_direction
	move_direction_no_y = camera_rotation_no_y * input_direction
	move_direction = move_direction.normalized()
	move_direction_no_y = move_direction_no_y.normalized()

func process_animation(delta):
	if !is_on_floor():
		$ModelRoot/Human/AnimationPlayer.play("Fall")
	elif move_direction != Vector3.ZERO:
		$ModelRoot/Human/AnimationPlayer.play("Run")
	else:
		$ModelRoot/Human/AnimationPlayer.play("Idle")
		
	if move_direction != Vector3.ZERO:
		$ModelRoot.basis = $ModelRoot.basis.slerp(Basis.looking_at(move_direction_no_y), ROTATE_SPEED * delta)
		if sprint_isdown and is_on_floor():
			$ModelRoot/Human/AnimationPlayer.speed_scale = 2
		else:
			$ModelRoot/Human/AnimationPlayer.speed_scale = 1

func process_noclip(delta):
	if noclip_isdown and noclip_toggle_cooldown == 0:
		noclip_on = !noclip_on
		$CollisionShape.disabled = !$CollisionShape.disabled
		noclip_toggle_cooldown = TOGGLE_COOLDOWN
	
	noclip_toggle_cooldown -= delta
	noclip_toggle_cooldown = clamp(noclip_toggle_cooldown, 0, TOGGLE_COOLDOWN)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		mouse_movement -= event.relative
	
	if event is InputEventKey:
		match event.keycode:
			KEY_W:
				forward_isdown = event.pressed
			KEY_S:
				backward_isdown = event.pressed
			KEY_A:
				left_isdown = event.pressed
			KEY_D:
				right_isdown = event.pressed
			KEY_V:
				noclip_isdown = event.pressed
			KEY_SHIFT:
				sprint_isdown = event.pressed
			KEY_SPACE:
				jump_isdown = event.pressed
			KEY_ESCAPE:
				mousecapture_isdown = event.pressed
