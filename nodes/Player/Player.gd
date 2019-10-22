extends "res://nodes/Character/Character.gd"
class_name Player

onready var interaction_area = $InteractionArea
onready var move_order_sound = $MoveOrderSound

export (float) var fixed_z = 2.0

export (Dictionary) var facts = {}
export (Dictionary) var abilities = {
	"shadow_switching": false
}


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


func unlock(ability: String):
	"""
	Unlock the given ability
	"""
	if ability in abilities:
		abilities[ability] = true


func can(ability: String):
	"""
	Tell if the ability is unlocked or not
	"""
	if not ability in abilities:
		return false
	
	return abilities[ability]


func knows(fact: String):
	"""
	Test wether or not the player knows something
	"""
	return facts.get(fact, false)


func learn(fact: String):
	"""
	Called when the player learns something
	"""
	facts[fact] = true