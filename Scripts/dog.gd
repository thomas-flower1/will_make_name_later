extends CharacterBody2D

# sprite images
@onready var sprites: Node2D = $sprites


@onready var game_manager: Node2D = $".."
@onready var camera: Camera2D = $"../Camera2D"
@onready var clock: Sprite2D = $"../clock/clock"


# collisions
@onready var original_collision: CollisionShape2D = $"Original Collision"
@onready var mini_collision: CollisionShape2D = $"Mini Collision"





# checking if the player is colliding with the lamp
var player_lamp_collision: bool = false
var player_box_collision: bool = false
var player_phone_collision: bool = false


# box
@onready var box: StaticBody2D = $"../bedroom/box"
@onready var box_collision: CollisionShape2D = $"../bedroom/box/box/box_collision"
@onready var static_box_collision: CollisionShape2D = $"../bedroom/box/static_box_collision"
@onready var desk_collision: CollisionShape2D = $"../bedroom/desk_collision/desk_collision"

@onready var t_shirt: Node2D = $"../bedroom/t-shirt"



@onready var bedroom_node: Node2D = $"../bedroom"

# ALL ROOM SPRITES
@onready var bedroom: Sprite2D = $"../bedroom/bedroom"
@onready var corner: Sprite2D = $"../corner/corner"
@onready var entrance: Sprite2D = $"../entrance/entrance"
@onready var corridor: Sprite2D = $"../corridor/corridor"
@onready var bathroom: Sprite2D = $"../bathroom/bathroom"
@onready var living_room: Sprite2D = $"../living room/living_room"
@onready var kitchen: Sprite2D = $"../kitchen/kitchen"
@onready var garden: Sprite2D = $"../garden/garden"
@onready var parents_bedroom: Sprite2D = $"../parent_bedroom/parents_bedroom"
@onready var porch: Sprite2D = $"../porch/porch"
@onready var phone: Sprite2D = $"../phone/phone"






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
	if visible:
		move_and_slide()
	

	
	
	
	
		
	
	
	
# called every frame
func _process(delta: float) -> void:
	const move_box_distance: int = 40
	
	# turning the lamp on and off
	if player_lamp_collision and Input.is_action_just_pressed("Interact"):
		if bedroom_node.bedroom_lamp_on:
			bedroom_node.bedroom_lamp_on = false
		else:
			bedroom_node.bedroom_lamp_on = true
			
	
	
	if box.position.y == -64:
		# we dont want the box to move past this point
		box_collision.disabled = true
		static_box_collision.disabled = true
		desk_collision.disabled = true # get rid of the collision preventing the dog getting on the desk
	
		
	# moving the box
	if player_box_collision and Input.is_action_just_pressed("Interact"):
		box.position.y -= move_box_distance
	
	
	# checking if the player is colliding with the phone
	if player_phone_collision and Input.is_action_just_pressed("Interact"):
		# need the player to disappear and also move the player to the new location
		camera.position = phone.position
		print('oj')
		visible = false
	
	
		
		
	



# MOVING BETWEEN THE ROOMS
func _on_to_corner_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corner.position
		position.x = -160
		position.y = -708

func _on_back_to_bedroom_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = bedroom.position
		position.x = 280
		position.y = -56


func _on_to_entrance_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = entrance.position
		position.x = 888

func _on_to_corridor_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 2072


func _on_back_to_corner_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corner.position
		position.x = 336


func _on_back_to_entrance_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = entrance.position
		position.x = 1526



func _on_to_living_room_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = living_room.position
		position.x = 2312
		position.y = -1704
		


func _on_to_bathroom_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = bathroom.position
		position.x = 2600
		position.y = -168


func _on_to_kitchen_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = kitchen.position
		position.x = 3280


func _on_back_to_corridor_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 2640
		position.y = -704

func _on_back_to_corridor_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 2640
		position.y = -1192

func _on_back_to_corridor_3_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = corridor.position
		position.x = 2736

func _on_to_garden_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = garden.position
		position.y = -152
		
		
func _on_back_to_kitchen_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = kitchen.position
		position.y = -688


func _on_to_parents_bedroom_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = parents_bedroom.position
		position.y = -56
		


func _on_back_to_entrance_2_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = entrance.position
		position.y = -712


func _on_to_porch_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = porch.position
		position.y = -1712
		

func _on_back_to_entrance_3_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		camera.position = entrance.position
		position.y = -936


func _on_lamp_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_lamp_collision = true
		


func _on_lamp_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_lamp_collision = false


func _on_box_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_box_collision = true



func _on_box_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_box_collision = false





func _on_tshirt_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		#add to inventory and remove the item
		t_shirt.queue_free()
		game_manager.inventory.append("t-shirt")
		


func _on_desk_phone_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_phone_collision = true

		


func _on_desk_phone_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_box_collision = false
