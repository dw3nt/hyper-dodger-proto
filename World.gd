extends Node

onready var mainMenu = $MainMenu
onready var game = $Game


func _ready():
	mainMenu.connect("play_game", self, "_on_MainMenu_play_game")
	
	
func _on_MainMenu_play_game():
	mainMenu.visible = false
	game.visible = true
	game.startGame()
