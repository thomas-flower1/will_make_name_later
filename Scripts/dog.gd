extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	const speed = 500
	
	var x_direction = 0
	var y_direction = 0
	# TODO add up and down
	# TODO add 4 direction movement
	
	#PLayer movement
	if Input.is_action_pressed("Left"):
		x_direction = -1
		# update the sprite
		sprite_2d.flip_h = false
	elif  Input.is_action_pressed(("Right")):
		x_direction = 1
		sprite_2d.flip_h = true
	elif Input.is_action_pressed(("Up")):
		y_direction = -1
	
	elif Input.is_action_pressed("Down"):
		y_direction = 1
		
	# to allow move and slide to update
	velocity.x = x_direction * speed
	velocity.y = y_direction * speed
	
	move_and_slide()
	
		
	
