extends Area2D
@export var id: int = 0 # will be used to determine what object it is
@onready var game_manager: Node2D = $".."


func _on_body_entered(body: Node2D) -> void:
	queue_free() # remove the object from the scene
	
	# now add the object to the inventory
	if id == 0:
		game_manager.inventory.append('Book')
	elif id == 1:
		game_manager.inventory.append('Pencil')
	elif id == 2:
		game_manager.inventory.append('Calculator')
	
