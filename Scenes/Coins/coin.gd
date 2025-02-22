extends Area2D

func _process(_delta):
	if position.x < -120:
		queue_free()
