extends CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	print('teste 2 ')
	if body.name == 'Player':
		get_tree().reload_current_scene()
	
	pass # Replace with function body.
