extends Node3D
class_name Scanner

@export var collision_config: CollisionConfigs
@export var scan_distance: float

var should_scan: bool = false
var look_direction: Vector3

func request_scan() -> void:
	should_scan = true

func look_at_new_direction(direction: Vector3) -> void:
	look_direction = direction.normalized()

# TODO: wtf am I doing here
func _physics_process(_delta: float) -> void:
	if not should_scan:
		return
	should_scan = false 
	
	var space_state = get_world_3d().direct_space_state

	var origin = global_transform.origin
	var end = origin + look_direction * scan_distance
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collision_mask = collision_config.get_poi_mask()    
	query.collide_with_areas = true
	#query.collision_mask = collision_config.get_poi_mask()
	var result = space_state.intersect_ray(query)
	if result.is_empty() || result.collider is not PointOfInterest:
		return
	
	var poi := result.collider as PointOfInterest
	
	# process the collision result
	print(poi.debug_string)   
