extends Control

signal settings_main_menu

onready var musicToggle = $CenterWrap/SettingsWrap/MusicWrap/MusicToggle
onready var musicVol = $CenterWrap/SettingsWrap/MusicWrap/MusicVolumeWrap/MusicVolume
onready var sfxToggle = $CenterWrap/SettingsWrap/SfxWrap/SfxToggle
onready var sfxVol = $CenterWrap/SettingsWrap/SfxWrap/SfxVolumeWrap/SfxVolume
onready var anim = $Anim


func startUp():
	var settingsData = DataSaver.readSettings()
	musicToggle.pressed = settingsData["musicEnabled"]
	musicVol.value = settingsData["musicVol"]
	sfxToggle.pressed = settingsData["sfxEnabled"]
	sfxVol.value = settingsData["sfxVol"]
	
	anim.play("fade_in")
	
	
func tearDown():
	DataSaver.writeSettings(musicToggle.pressed, musicVol.value, sfxToggle.pressed, sfxVol.value)
	anim.play("fade_out")


func _on_MainMenu_pressed():
	emit_signal("settings_main_menu")
