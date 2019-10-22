extends "res://nodes/Character/Character.gd"
class_name Player

onready var interaction_area = $InteractionArea
onready var move_order_sound = $MoveOrderSound

export (float) var fixed_z = 2.0


func is_in_range(node: Interactable):
	"""
	Check if the given interactable is in the range of the player
	true if it is
	"""
	return interaction_area.overlaps_body(node)


func _ready():
	interaction_disabled = true


func move_to(target: Vector3):
	target.z = fixed_z
	
	.move_to(target)
	
	move_order_sound.play()