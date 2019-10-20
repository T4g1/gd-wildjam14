extends Spatial
"""
Entry point of main scene
"""

export (bool) var debug = true

var GameNode = load("res://scenes/Game.tscn")
var game: Game

onready var title = $Title
onready var camera = $Camera


func _ready():
	title.connect("play", self, "_on_play")
	
	if debug:
		show_game()
	else:
		show_title()


func _on_play():
	show_game()


func _on_game_over():
	show_title()


func clear_game():
	"""
	Remove game node
	"""
	if game:
		remove_child(game)
		game = null


func show_title():
	"""
	Goes to title
	"""
	camera.reset_position()
	
	clear_game()
	title.show()


func show_game():
	game = GameNode.instance()
	var __ = game.connect("game_over", self, "_on_game_over")
	add_child(game)
	
	title.hide()