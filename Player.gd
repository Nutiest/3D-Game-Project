extends CharacterBody3D

@onready var pause_menu := $"TwistPivot/PitchPivot/SpringArm3D/Camera3D/Pause Menu"
@onready var settings_menu := $"TwistPivot/PitchPivot/SpringArm3D/Camera3D/Settings Menu"
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot
@onready var spring_arm := $TwistPivot/PitchPivot/SpringArm3D
@onready var animation := $AnimationTree
@onready var mesh := $Node3D/MeshInstance3D
@export var paused := false

var SPEED := 10.0
const JUMP_VELOCITY := 8
var sprint := false
var jumping := false

var mouse_sensitivity := 0.002
var twist_input := 0.0
var pitch_input := 0.0

#@onready var twist_pivot := $TwistPivot
#@onready var pitch_pivot := $TwistPivot/PitchPivot

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pause_menu.hide()
	settings_menu.hide()


func _physics_process(delta) -> void:
	if is_on_floor():
		SPEED = 10.0
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * 2

	# Handle jump.
	jumping = false
	
	if Input.is_action_pressed("Jump"):
		jumping = true
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			SPEED = SPEED*1.2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Backward")
	var direction = (twist_pivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		$Node3D.look_at(position + Vector3(direction.x,0,direction.z))
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		if Input.is_action_just_pressed("Sprint"):
			sprint = !sprint
		
		if sprint:
			velocity.x = direction.x * SPEED * 1.5
			velocity.z = direction.z * SPEED * 1.5
	else:
		sprint = false
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	animation.set("parameters/conditions/idle", (!direction and is_on_floor()))
	animation.set("parameters/conditions/walk", (direction and !sprint and is_on_floor()))
	animation.set("parameters/conditions/run", (sprint and is_on_floor()))
	animation.set("parameters/conditions/jump", jumping)
	
	if Input.is_action_just_pressed("Pause"):
		open_close_pause_menu()
	
	mouse_movement()
	move_and_slide()


func mouse_movement() -> void:
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	#spring_arm.rotation.z = 0.0
	pitch_pivot.rotation_degrees.x = clamp(pitch_pivot.rotation_degrees.x, -60, 70)
	
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("Zoom In"):
		spring_arm.spring_length = spring_arm.spring_length-0.5
	elif Input.is_action_just_pressed("Zoom Out"):
		spring_arm.spring_length = spring_arm.spring_length+0.5
	
	spring_arm.spring_length = clamp(spring_arm.spring_length, 1.5, 15.0)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity

func open_close_pause_menu() -> void:
	if !paused:
		pause_menu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Engine.time_scale = 0
		paused = !paused
	else:
		pause_menu.hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		Engine.time_scale = 1
		paused = !paused

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
