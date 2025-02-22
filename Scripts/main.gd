extends Node

@export var obstacle: PackedScene
@export var coin: PackedScene

var dynamic_object_speed: int = 700
var health_decrease: int = 3
var spawned_object_position_x: int = 1700
var last_obstacle_position: String
var health: float = 100
var score: float = 0.0

func _ready():
	$GameOver.hide()

func _process(delta):
	# position.x -= delta * dynamic_object_speed
	for dynamic_object in get_tree().get_nodes_in_group("DynamicObject"):
		dynamic_object.position.x -= delta * dynamic_object_speed

	if health > 0:
		health -= health_decrease * delta
		$UI/HealthBar.value = health
	else:
		game_over()

	score += delta
	var formatted_score: String = str(score)
	var decimal_index = formatted_score.find(".")
	formatted_score = formatted_score.left(decimal_index)
	$UI/HealthBar/ScoreLabel.text = formatted_score

func _on_spawner_timer_timeout():
	var random: int = randi() % 2
	var obstacle_instance: Area2D = obstacle.instantiate()
	obstacle_instance.body_entered.connect(_on_obstacle_collided)
	$Obstacles.add_child(obstacle_instance)
	obstacle_instance.position.x = spawned_object_position_x

	if random == 0:
		obstacle_instance.position.y = 200
		last_obstacle_position = "up"

	if random == 1:
		obstacle_instance.position.y = 800
		obstacle_instance.rotation_degrees = 180
		last_obstacle_position = "down"

func _on_coin_timer_timeout():
	var random_position: int = randi() % 3

	if random_position == 0 and last_obstacle_position == "up":
		return

	if random_position == 2 and last_obstacle_position == "down":
		return

	var coin_instance: Area2D = coin.instantiate()
	coin_instance.body_entered.connect(_on_coin_collided.bind(coin_instance))
	$Coins.add_child(coin_instance)
	coin_instance.position.y = 280 + random_position * 200
	coin_instance.position.x = spawned_object_position_x

func _on_coin_collided(body: Node2D, coin_instance: Area2D):
	if body.is_in_group("Player"):
		health += 4
		coin_instance.queue_free()

func _on_obstacle_collided(body: Node2D):
	if body.is_in_group("Player"):
		health = 0


func game_over():
	$GameOver.show()
	get_tree().paused = true