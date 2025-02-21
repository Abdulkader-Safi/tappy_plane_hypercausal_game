extends Node

@export var obstacle: PackedScene

var dynamic_object_speed: int = 700
var health_decrease: int = 3
var spawned_object_position_x: int = 1700
var health: float = 100
var score: float = 0.0

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

func _on_spawner_timer_timeout():
	var random: int = randi() % 2
	var obstacle_instance: Area2D = obstacle.instantiate()
	$Obstacles.add_child(obstacle_instance)
	obstacle_instance.position.x = spawned_object_position_x

	if random == 0:
		obstacle_instance.position.y = 200

	if random == 1:
		obstacle_instance.position.y = 800
		obstacle_instance.rotation_degrees = 180