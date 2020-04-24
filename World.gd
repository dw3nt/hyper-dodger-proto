extends Node

var activeScreen

onready var mainMenu = $Screens/MainMenu
onready var game = $Screens/Game
onready var gameOver = $Screens/GameOver


func _ready():
	mainMenu.connect("play_game", self, "_on_MainMenu_play_game")
	game.connect("gameplay_ended", self, "_on_Game_gameplay_ended")
	gameOver.connect("retry_game", self, "_on_GameOver_retry_game")
	gameOver.connect("main_menu_pressed", self, "_on_GameOver_main_menu_pressed")
	
	switchScreens(mainMenu)
	
	
func switchScreens(goToScreen):
	if activeScreen:
		activeScreen.tearDown()
		
	goToScreen.startUp()
	activeScreen = goToScreen
	
	
func _on_MainMenu_play_game():
	switchScreens(game)
	
	
func _on_Game_gameplay_ended():
	switchScreens(gameOver)
	gameOver.score = game.points


func _on_GameOver_retry_game():
	switchScreens(game)


func _on_GameOver_main_menu_pressed():
	switchScreens(mainMenu)
