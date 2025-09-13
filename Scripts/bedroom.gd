extends Node2D
@onready var static_lamp: Sprite2D = $lamp/static_lamp
@onready var animated_lamp: AnimatedSprite2D = $lamp/animated_lamp


var bedroom_lamp_on: bool = false

func _process(_delta):
	
	 # switching on the lamp
	if bedroom_lamp_on:
		animated_lamp.visible = true
		
	else:
		animated_lamp.visible = false
		
		
