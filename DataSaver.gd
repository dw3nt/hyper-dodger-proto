extends Node

const SCORE_PATH = "user://score.data"
const SETTINGS_PATH = "user://settings.data"

var scoreFile
var score
var highscore

var settingsFile
var musicEnabled
var musicVol
var sfxEnabled
var sfxVol


func _ready():
	initScore()
	initSettings()
	
	
func initScore():
	scoreFile = File.new()
	if !scoreFile.file_exists(SCORE_PATH):
		score = 0
		highscore = 0
		writeScores(score, highscore)
	else:
		var scoreData = readScores()
		score = scoreData["score"]
		highscore = scoreData["highscore"]
		
		
func initSettings():
	settingsFile = File.new()
	if !settingsFile.file_exists(SETTINGS_PATH):
		musicEnabled = true
		musicVol = 100
		sfxEnabled = true
		sfxVol = 100
		writeSettings(musicEnabled, musicVol, sfxEnabled, sfxVol)
	else:
		var settingsData = readSettings()
		musicEnabled = settingsData["musicEnabled"]
		musicVol = settingsData["musicVol"]
		sfxEnabled = settingsData["sfxEnabled"]
		sfxVol = settingsData["sfxVol"]
	

func writeScores(_score, _highscore):
	scoreFile.open(SCORE_PATH, File.WRITE)
	scoreFile.store_var({ "score": _score, "highscore": _highscore })
	scoreFile.close()
	
	
func readScores():
	scoreFile.open(SCORE_PATH, File.READ)
	var data = scoreFile.get_var()
	scoreFile.close()
	return data
	
	
func writeSettings(_musicEnabled, _musicVol, _sfxEnabled, _sfxVol):
	settingsFile.open(SETTINGS_PATH, File.WRITE)
	settingsFile.store_var({
		"musicEnabled": _musicEnabled, 
		"musicVol": _musicVol, 
		"sfxEnabled": _sfxEnabled, 
		"sfxVol": _sfxVol 
	})
	settingsFile.close()
	
	
func readSettings():
	settingsFile.open(SETTINGS_PATH, File.READ)
	var data = settingsFile.get_var()
	settingsFile.close()
	return data
