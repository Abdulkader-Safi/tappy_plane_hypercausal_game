extends RigidBody2D

@export var impulse_force: int = 1500

func _process(_delta):
	if Input.is_action_just_pressed('click'):
		apply_central_impulse(Vector2.UP * impulse_force)