extends Node3D

func look_at_new_direction(direction: Vector3) -> void:
	transform = transform.looking_at(direction)
