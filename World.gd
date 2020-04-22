extends Node

onready var mainMenu = $MainMenu
onready var game = $Game


func _ready():
	mainMenu.connect("play_game", self, "_on_MainMenu_play_game")
	game.connect("go_to_menu", self, "_on_Game_go_to_menu")
	
	
func _on_MainMenu_play_game():
	mainMenu.visible = false
	game.visible = true
	game.startGame()
	
	
func _on_Game_go_to_menu():
	mainMenu.visible = true
	game.visible = false
