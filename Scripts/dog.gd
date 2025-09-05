extends CharacterBody2D

@onready var left_right: Sprite2D = $left_right
@onready var up_down: Sprite2D = $up_down
@onready var bed: Area2D = $"../Bed" # the collision to interact with the bed
@onready var camera_2d: Camera2D = $"../Camera2D"

# checking if the player is currentyl colliding with the bed
var player_bed_collision: bool = false

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
	
# called every frame
func _process(delta: float) -> void:
	
	# checking if the player interacts with the bed
	if player_bed_collision and Input.is_action_just_pressed("Interact"):
		camera_2d.position.y += 800
		player_bed_collision = false
		
	

# if the character is infront of the bed
func _on_bed_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = true
	


func _on_bed_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = false
