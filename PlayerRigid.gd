extends RigidBody3D

#var mouse_sensitivity := 0.002
#var twist_input := 0.0
#var pitch_input := 0.0
#
#@onready var twist_pivot := $TwistPivot
#@onready var pitch_pivot := $TwistPivot/PitchPivot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass
	#var input := Vector3.ZERO
	#input.x = Input.get_axis("Left", "Right")
	#input.z = Input.get_axis("Forward", "Backward")
	#if Input.is_action_just_pressed("Jump"):
		#input.y = 5
		#input.x*20
		#input.z*20
		#apply_central_force(input * 5000.0 * delta)
	##else: input.y = 0
	#
	#apply_central_force(twist_pivot.basis * input * 3000.0 * delta)
	#
	#if ((Input.mouse_mode == Input.MOUSE_MODE_CAPTURED) and Input.is_action_just_pressed("ui_cancel")):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#elif ((Input.mouse_mode == Input.MOUSE_MODE_VISIBLE) and Input.is_action_just_pressed("ui_cancel")):
		#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	#
	#
	#twist_pivot.rotate_y(twist_input)
	#pitch_pivot.rotate_x(pitch_input)
	#pitch_pivot.rotation_degrees.x = clamp(pitch_pivot.rotation_degrees.x, -90, 32)
	#
	#twist_input = 0.0
	#pitch_input = 0.0
	#
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			#twist_input = - event.relative.x * mouse_sensitivity
			#pitch_input = - event.relative.y * mouse_sensitivity
