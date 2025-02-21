extends Node

@export var dynamic_object_speed: int = 700
@export var health_decrease: int = 3
@export var health: float = 100
@export var score: float = 0.0

func _process(delta):
	# position.x -= delta * dynamic_object_speed
	for dynamic_object in get_tree().get_nodes_in_group("DynamicObject"):
		dynamic_object.position.x -= delta * dynamic_object_speed

	if health > 0:
		health -= health_decrease * delta
		$UI/HealthBar.value = health

	score += delta
	var formatted_score: String = str(score)
	var decimal_index = formatted_score.find(".")
	formatted_score = formatted_score.left(decimal_index + 3)
	$UI/HealthBar/ScoreLabel.text = formatted_score
	print(decimal_index)