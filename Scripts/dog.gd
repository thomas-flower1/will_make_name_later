extends CharacterBody2D

# sprite images
@onready var sprites: Node2D = $sprites




@onready var mini: Sprite2D = $mini

@onready var game_manager: Node2D = $".."
@onready var bed: Area2D = $"../Bed" # the collision to interact with the bed
@onready var camera: Camera2D = $"../Camera2D"
@onready var clock: Sprite2D = $"../clock/clock"


# collisions
@onready var original_collision: CollisionShape2D = $"Original Collision"
@onready var mini_collision: CollisionShape2D = $"Mini Collision"



# checking if the player is currentyl colliding with the bed
var player_bed_collision: bool = false

# checking if the player is colliding the with door
var player_door_collision: bool = false
@onready var corner: Sprite2D = $"../corner/corner"


# corridor
@onready var corridor: Sprite2D = $"../corridor/corridor"

# kitchen
@onready var kitchen: Sprite2D = $"../kitchen/kitchen"

# garden
@onready var garden: Sprite2D = $"../garden/garden"



# checking if the player collides with the clock collision
var player_clock_collision: bool = false

func _physics_process(delta: float) -> void:
	var speed = 500
	
	var x_direction: int = 0
	var y_direction: int = 0
	var current_sprite = null
	var flip: bool = false
	
	#PLayer movement
	if Input.is_action_pressed("Left"):
		x_direction = -1
		current_sprite = "left_right"
		flip = false
	
	elif Input.is_action_pressed("Right"):
		x_direction = 1
		current_sprite = "left_right"
		flip = true
	
	elif Input.is_action_pressed("Up"):
		y_direction = -1
		current_sprite = "up"
	
	elif Input.is_action_pressed("Down"):
		y_direction = 1
		current_sprite = "down"
		
	else:
		x_direction = 0
		y_direction = 0
		flip = false
		current_sprite  = "stationary"
		
	
	

	# then looping over all the sprites
	for sprite in sprites.get_children():
	
		
		
		if sprite.name == current_sprite:
			sprite.visible = true
			sprite.flip_h = flip
			
		else:
			sprite.visible = false
	
		
		
		
	# to allow move and slide to update
	velocity.x = x_direction * speed
	velocity.y = y_direction * speed
	move_and_slide()
	

	
	
	
	# checking if the player is in the maze
	#if game_manager.in_maze:
		#
		## TODO hide all the sprites in the sprite node
		#
		#mini.visible = true
		#
		#mini_collision.disabled = false
		#original_collision.disabled = true
		#
		#
		## change the speed, need to revert back
		#speed = 250
		#
		
	
	
	
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
		camera.position.x = corner.position.x
		camera.position.y = corner.position.y

		position.x = -160
		position.y = -624
		
	elif player_clock_collision and Input.is_action_just_pressed("Interact"):
		clock.visible = true
		
	

# if the character is infront of the bed
func _on_bed_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = true
		
		
func _on_bed_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_bed_collision = false


# if the player collides with the door
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

# if the player enters the place with the clock
func _on_collision_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_clock_collision = true


func _on_collision_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_clock_collision = false



func _on_back_to_corner_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corner.position
		position.x = 320


func _on_to_kitchen_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = kitchen.position
		position.x = 2176


func _on_back_to_corridor_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 1512



func _on_to_corridor_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 872


func _on_to_garden_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = garden.position
		position.y = -160


func _on_back_to_kitchen_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = kitchen.position
		position.y = -624
		
