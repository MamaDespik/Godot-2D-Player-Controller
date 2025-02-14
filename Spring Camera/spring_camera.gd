extends Camera2D

@export var spring_force:float = .5
@export var margin:int = 10

var parent:Player

func _ready() -> void:
	parent = get_parent()
	return

func _physics_process(delta: float) -> void:
	var diff = parent.position - position
	if abs(diff.x) > margin or abs(diff.y) >margin:
		var change = diff * spring_force * delta
		position = position + change
	#position = parent.position
	return
