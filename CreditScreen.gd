extends Control

signal credit_main_menu

const LINK_MAP = {
	# Fonts
	"FontAuthorLink": "https://fontstruct.com/fontstructors/623307/30100flo",
	"FontLicenseLink": "https://creativecommons.org/licenses/by-sa/3.0/",
	"Graph35pxFontLink": "http://fontstruct.com/fontstructions/show/664062",
	"ThirteenPixelFontsFontLink": "http://fontstruct.com/fontstructions/show/761985",
	"3DThirteenPixelFontsFontLink": "http://fontstruct.com/fontstructions/show/851388",
	
	# Music
	"MusicAuthorLink": "http://anttismusic.blogspot.com/",
	"MusicLicenseLink": "https://creativecommons.org/licenses/by/3.0/",
	"WhiteBoyInstrumental": "https://www.soundclick.com/music/songInfo.cfm?songID=13984655",
	
	# SFX
	"StumpyStrustLabel": "https://opengameart.org/content/ui-sounds",
	"sauer2Label": "https://opengameart.org/content/alien-sounds"
}

onready var anim = $Anim


func _ready():
	for node in get_tree().get_nodes_in_group("external_link"):
		node.connect("pressed", self, "_on_ExternalLink_pressed", [ LINK_MAP[node.name] ])


func startUp():
	anim.play("fade_in")
	
	
func tearDown():
	anim.play("fade_out")


func _on_MainMenu_pressed():
	emit_signal("credit_main_menu")


func _on_ExternalLink_pressed(link):
	OS.shell_open(link)
