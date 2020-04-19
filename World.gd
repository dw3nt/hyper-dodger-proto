extends Node

const PLAYER_Y = 666

var trackPosX = []
var playerTrackPosKey

onready var tracksWrap = $DodgeTracks
onready var player = $Player


func _ready():
	for track in tracksWrap.get_children():
		trackPosX.push_back(track.position.x)
		
	trackPosX.sort()	# in case track nodes ever get out of order
	playerTrackPosKey = ceil(trackPosX.size() / 2)
	player.position = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
	
	player.connect("switch_tracks", self, "_on_Player_switch_track")
	
	
func _on_Player_switch_track(dir):
	var newKey = playerTrackPosKey + dir
	if newKey >= 0 && newKey < trackPosX.size():
		playerTrackPosKey = newKey
		player.position = Vector2(trackPosX[playerTrackPosKey], PLAYER_Y)
