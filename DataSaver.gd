extends Node

const SCORE_PATH = "user://score.data"

var scoreFile
var score
var highscore


func _ready():
	scoreFile = File.new()
	if !scoreFile.file_exists(SCORE_PATH):
		score = 0
		highscore = 0
		writeScores(score, highscore)
	else:
		var scoreData = readScores()
		score = scoreData["score"]
		highscore = scoreData["highscore"]
	

func writeScores(_score, _highscore):
	scoreFile.open(SCORE_PATH, File.WRITE)
	scoreFile.store_var({ "score": _score, "highscore": _highscore })
	scoreFile.close()
	
	
func readScores():
	scoreFile.open(SCORE_PATH, File.READ)
	var data = scoreFile.get_var()
	scoreFile.close()
	return data
	
