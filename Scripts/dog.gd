extends CharacterBody2D

# sprite images
@onready var left_right: Sprite2D = $left_right
@onready var up: Sprite2D = $up
@onready var down: Sprite2D = $down
@onready var mini: Sprite2D = $mini

@onready var game_manager: Node2D = $".."
@onready var bed: Area2D = $"../Bed" # the collision to interact with the bed
@onready var camera_2d: Camera2D = $"../Camera2D"

# checking if the player is currentyl colliding with the bed
var player_bed_collision: bool = false

func _physics_process(delta: float) -> void:
	const speed = 250
	
	var x_direction = 0
	var y_direction = 0
	# TODO add up and down
	# TODO add 4 direction movement
	
	#PLayer movement
	if Input.is_action_pressed("Left"):
		x_direction = -1
		left_right.flip_h = false
		left_right.visible = true
		up.visible = false
		down.visible = false
	elif  Input.is_action_pressed(("Right")):
		x_direction = 1
		left_right.flip_h = true
		left_right.visible = true
		down.visible = false
		up.visible = false
	elif Input.is_action_pressed(("Up")):
		y_direction = -1
		left_right.visible = false
		down.visible = false
		up.visible = true
	elif Input.is_action_pressed("Down"):
		y_direction = 1
		left_right.visible = false
		up.visible = false
		down.visible = true
		
		
	# to allow move and slide to update
	velocity.x = x_direction * speed
	velocity.y = y_direction * speed
	
	
	
	# checking if the player is in the maze
	if game_manager.in_maze:
		left_right.visible = false
		down.visible = false
		up.visible = false
		mini.visible = true
		
		
	
	move_and_slide()
	
# called every frame
func _process(delta: float) -> void:
	
	# checking if the player interacts with the bed
	if player_bed_collision and Input.is_action_just_pressed("Interact"):
		camera_2d.position.y += 1456
		camera_2d.zoom.x = 0.5
		camera_2d.zoom.y = 0.5
		player_bed_collision = false
		game_manager.in_maze = true
		
		# move the player to the maze
		position.x = -360
		position.y = 840
		
	

# if the character is infront of the bed
func _on_bed_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = true
		
	


func _on_bed_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = false


func _on_static_body_2d_mouse_shape_entered(shape_idx: int) -> void:
	print('ok')
