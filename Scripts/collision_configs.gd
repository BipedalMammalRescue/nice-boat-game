extends Resource
class_name CollisionConfigs

@export var physical_collision_mask: int = 0
@export var point_of_interest_mask: int = 1

func get_poi_mask() -> int:
	return 1 << point_of_interest_mask
	
func get_physical_mask() -> int:
	return 1 << physical_collision_mask
