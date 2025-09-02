extends StaticBody2D



# for bottom
func _on_bottom_body_entered(body: Node2D) -> void:
	position.y -= 10


func _on_right_body_entered(body: Node2D) -> void:
	position.x -= 10


func _on_up_body_entered(body: Node2D) -> void:
	position.y += 10


func _on_left_body_entered(body: Node2D) -> void:
	position.x += 10
