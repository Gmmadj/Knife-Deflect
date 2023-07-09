extends Node2D

# Префабы ножей
@export var knives : Array[PackedScene]
# Ограничение угла, с которого можно запустить нож  [0, 2PI]
@export var positions : Array[Vector2]
# Типы запускаемых ножей
@export var types : Array[int]
#@export var knife_scene: PackedScene = preload("res://Prefabs/knife.tscn")
@export var warning_scene: PackedScene = preload("res://Prefabs/warning.tscn")
@export var distance: float = 600.0

@onready var cur_index : int

signal victory

func new_game():
	$MobTimer.start()
	cur_index = 0

func _ready():
	new_game()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	spawn_on_circle()

func spawn_on_circle():
	var rand: float = (randf() * (positions[cur_index].y - positions[cur_index].x) + positions[cur_index].x) * PI
	var dir: Vector2 = Vector2(cos(rand), sin(rand))
	var attack : Node2D = knives[types[cur_index]].instantiate()
	var warning : Node2D = warning_scene.instantiate()
	attack.position = dir * distance
	attack.rotation = rand - PI * 0.5
	add_child(attack)
	warning.max_dist = distance
	attack.add_child(warning)
	if(cur_index == positions.size() - 1):
		$MobTimer.stop()
		emit_signal("victory")
	cur_index += 1
	
