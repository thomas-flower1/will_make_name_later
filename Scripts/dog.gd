extends CharacterBody2D

# sprite images
@onready var left_right: Sprite2D = $left_right
@onready var up: Sprite2D = $up
@onready var down: Sprite2D = $down
@onready var mini: Sprite2D = $mini

@onready var game_manager: Node2D = $".."
@onready var bed: Area2D = $"../Bed" # the collision to interact with the bed
@onready var camera: Camera2D = $"../Camera2D"


# collisions
@onready var original_collision: CollisionShape2D = $"Original Collision"
@onready var mini_collision: CollisionShape2D = $"Mini Collision"


# checking if the player is currentyl colliding with the bed
var player_bed_collision: bool = false

# checking if the player is colliding the with door
var player_door_collision: bool = false

func _physics_process(delta: float) -> void:
	var speed = 500
	
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
		
		mini_collision.disabled = false
		original_collision.disabled = true
		
		
		# change the speed, need to revert back
		speed = 250
		
		
	
	move_and_slide()
	
# called every frame
func _process(delta: float) -> void:
	
	# checking if the player interacts with the bed
	if player_bed_collision and Input.is_action_just_pressed("Interact"):
		camera.position.y = 880
		player_bed_collision = false
		game_manager.in_maze = true
		
		# move the player to the maze
		position.x = -357
		position.y = 1196
	
	# checking if the player interacts with the door
	elif player_door_collision and Input.is_action_just_pressed("Interact"):
		camera.position.x = 1026
		position.x = 712
		position.y = 88
		
		
	

# if the character is infront of the bed
func _on_bed_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = true
		
	


func _on_bed_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = false


func _on_door_collision_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_door_collision = true


func _on_door_collision_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_door_collision = false


func _on_back_to_bedroom_body_entered(body: Node2D) -> void:
	position.x = 281
	position.y = -73
	camera.position.x = 0
	camera.position.y = 0
