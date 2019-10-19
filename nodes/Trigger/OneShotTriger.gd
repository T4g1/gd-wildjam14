extends "res://nodes/Trigger/Trigger.gd"


export(String, FILE, "*.json") var path_story

onready var dialog = $Dialog


func _ready():
	dialog.load_story(path_story)


func on_triggered():
	dialog.continue_story()
