extends Node3D
class_name ShipController

signal look_direction_update(new_look_direction: Vector3)
signal velocity_update(new_velocity: Vector3)

@export var angular_speed: float
@export var accelerate_power: float
@export var decelerate_power: float
@export var eject_power: float
@export var body_mass: float

@export var drag_factor: float

@export var min_pitch: float
@export var max_pitch: float

var look_direction: Vector3
var velocity: Vector3

# transient state
var current_acceleration: Vector3

func _enter_tree() -> void:
	look_direction = - transform.basis.z
	current_acceleration = Vector3.ZERO

func _process(delta: float) -> void:
	if current_acceleration.length() > 0:
		velocity += current_acceleration
		velocity_update.emit(velocity)
	
	transform = transform.translated(velocity * delta)
	
	if velocity.length() > 0:
		var deceleration = pow(velocity.length(), 2) * drag_factor / body_mass
		velocity -= velocity.normalized() * deceleration * delta
		if current_acceleration.length() <= 0 && velocity.length() <= 0.1:
			velocity = Vector3.ZERO
	
	current_acceleration = Vector3.ZERO

func accelerate(delta: float) -> void:
	current_acceleration += accelerate_power / body_mass * delta * look_direction
	
func decelerate(delta: float) -> void:
	current_acceleration -= decelerate_power / body_mass * delta * look_direction
	
func apply_new_pitch(pitch: float) -> void:
	var new_look_direction = look_direction
	new_look_direction.y = 0
	new_look_direction = new_look_direction.normalized()
	new_look_direction.y = tan(pitch)
	look_direction = new_look_direction.normalized()
	look_direction_update.emit(look_direction)
	
func dive(delta: float) -> void:
	var angular_shift = angular_speed * delta
	var pitch = asin(look_direction.y)
	pitch = clamp(pitch - angular_shift, min_pitch, max_pitch)
	apply_new_pitch(pitch)
	look_direction_update.emit(look_direction)
	
func ascend(delta: float) -> void:
	var angular_shift = angular_speed * delta
	var pitch = asin(look_direction.y)
	pitch = clamp(pitch + angular_shift, min_pitch, max_pitch)
	apply_new_pitch(pitch)
	look_direction_update.emit(look_direction)
	
func turn_left(delta: float) -> void:
	var angular_shift = angular_speed * delta
	look_direction = look_direction.rotated(Vector3(0, 1, 0), angular_shift)
	look_direction_update.emit(look_direction)

func turn_right(delta: float) -> void:
	var angular_shift = angular_speed * delta
	look_direction = look_direction.rotated(Vector3(0, 1, 0), - angular_shift)
	look_direction_update.emit(look_direction)

func eject(delta: float, direction: Vector3) -> void:
	current_acceleration += direction * delta * eject_power / body_mass
