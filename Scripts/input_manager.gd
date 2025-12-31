extends Node

signal accelerate(delta: float)
signal decelerate(delta: float)
signal ascend(delta: float)
signal dive(delta: float)
signal left(delta: float)
signal right(delta: float)

signal translate(delta: float, direction: Vector3)

signal scan()
signal capture()

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
	if Input.is_action_pressed("translate_up"):
		translate.emit(delta, Vector3.UP)
	if Input.is_action_pressed("translate_down"):
		translate.emit(delta, Vector3.DOWN)
	if Input.is_action_pressed("translate_left"):
		translate.emit(delta, Vector3.LEFT)
	if Input.is_action_pressed("translate_right"):
		translate.emit(delta, Vector3.RIGHT)
	if Input.is_action_just_pressed("scan"):
		scan.emit()
	if Input.is_action_just_pressed("capture"):
		capture.emit()
