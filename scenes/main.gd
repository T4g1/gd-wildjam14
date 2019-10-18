extends Spatial
"""
Entry point of main scene
"""


var GameNode = load("res://scenes/Game.tscn")
var game: Game
onready var title = $Title


func _ready():
	title.connect("play", self, "_on_play")
	
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
	clear_game()
	title.show()


func show_game():
	game = GameNode.instance()
	game.connect("game_over", self, "_on_game_over")
	add_child(game)
	
	title.hide()