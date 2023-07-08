extends Sprite2D

@export var speed : float = 100.0

var velocity : Vector2 = Vector2()

func _ready():
	velocity = Vector2.UP.rotated(self.rotation) * speed


func _process(delta):
	position += velocity * delta


func _on_damagebox_entered(area):
	if area is HitboxComponent : 
		call_deferred("rebase",area)

func rebase(area : Node2D):
	$DamageboxComponent.set_deferred("monitoring",false)
	set_process(false)
	var parent = area.get_parent()
	reparent(parent,true)
	
