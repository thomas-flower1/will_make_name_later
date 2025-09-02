extends CharacterBody2D

@onready var left_right: Sprite2D = $left_right
@onready var up_down: Sprite2D = $up_down

func _physics_process(delta: float) -> void:
	const speed = 500
	
	var x_direction = 0
	var y_direction = 0
	# TODO add up and down
	# TODO add 4 direction movement
	
	#PLayer movement
	if Input.is_action_pressed("Left"):
		x_direction = -1
		left_right.flip_h = false
		left_right.visible = true
		up_down.visible = false
	elif  Input.is_action_pressed(("Right")):
		x_direction = 1
		left_right.flip_h = true
		left_right.visible = true
		up_down.visible = false
	elif Input.is_action_pressed(("Up")):
		y_direction = -1
		left_right.visible = false
		up_down.visible = true
	elif Input.is_action_pressed("Down"):
		y_direction = 1
		left_right.visible = false
		up_down.visible = true
		
	# to allow move and slide to update
	velocity.x = x_direction * speed
	velocity.y = y_direction * speed
	
	move_and_slide()
	
	
	
