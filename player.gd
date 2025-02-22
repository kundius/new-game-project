extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 8

var leg = 'left'

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if (velocity.x > 0):
			$colobok_anim_v3/AnimationPlayer.play("Armature_002Action")
			#$colobok_anim_v3/AnimationPlayer.play('Armature_002Action')
		elif (velocity.x < 0):
			#$colobok_anim_v3/AnimationPlayer.play("Armature_001Action")
			$colobok_anim_v3/AnimationPlayer.play('Armature_001Action')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$colobok_anim_v3/AnimationPlayer.stop()

	move_and_slide()
	
	# handle camera
	var camera_position = $Camera_Controller.position
	camera_position.x = lerp(camera_position.x, position.x, 0.08)
	#camera_position.z = lerp(camera_position.z, position.z, 0.08)
	camera_position.y = lerp(camera_position.y, position.y, 0.08)
	$Camera_Controller.position = camera_position
	
	#$colobok_anim2/AnimationPlayer.queue("leftAction")
	#$colobok_anim2/AnimationPlayer.queue("rightAction")
	#if (leg == 'left'):
		#leg = 'right'
		#$colobok_anim2/AnimationPlayer.queue("leftAction")
	#else:
		#leg = 'left'
		#$colobok_anim2/AnimationPlayer.queue("rightAction")
	
