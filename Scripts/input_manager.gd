extends Node

signal accelerate(delta: float)
signal decelerate(delta: float)
signal ascend(delta: float)
signal dive(delta: float)
signal left(delta: float)
signal right(delta: float)

func _process(delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		accelerate.emit(delta)
	if Input.is_action_pressed("decelerate"):
		decelerate.emit(delta)
	if Input.is_action_pressed("ascend"):
		ascend.emit(delta)
	if Input.is_action_pressed("dive"):
		dive.emit(delta)
	if Input.is_action_pressed("left"):
		left.emit(delta)
	if Input.is_action_pressed("right"):
		right.emit(delta)
