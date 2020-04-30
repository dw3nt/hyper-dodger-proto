extends Control

signal settings_main_menu
signal enable_music

const MUSIC_BUS_NAME = "Music"
const SFX_BUS_NAME = "Sfx"

var musicEnabled setget setMusicEnabled
var musicVol setget setMusicVol
var sfxEnabled setget setSfxEnabled
var sfxVol setget setSfxVol

onready var musicCheck = $CenterWrap/SettingsWrap/MusicWrap/MusicToggle
onready var musicVolSlider = $CenterWrap/SettingsWrap/MusicWrap/MusicVolumeWrap/MusicVolume
onready var sfxCheck = $CenterWrap/SettingsWrap/SfxWrap/SfxToggle
onready var sfxVolSlider = $CenterWrap/SettingsWrap/SfxWrap/SfxVolumeWrap/SfxVolume
onready var anim = $Anim


func _ready():
	var settingsData = DataSaver.readSettings()
	self.musicEnabled = settingsData["musicEnabled"]
	self.musicVol = settingsData["musicVol"]
	self.sfxEnabled = settingsData["sfxEnabled"]
	self.sfxVol = settingsData["sfxVol"]


func startUp():	
	anim.play("fade_in")
	
	
func tearDown():
	DataSaver.writeSettings(musicCheck.pressed, musicVolSlider.value, sfxCheck.pressed, sfxVolSlider.value)
	anim.play("fade_out")
	
	
func setMusicEnabled(val):
	musicCheck.pressed = val
	var busIndex = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	AudioServer.set_bus_mute(busIndex, !val)
	musicEnabled = val
	emit_signal("enable_music")
	
	
func setMusicVol(val):
	musicVolSlider.value = val
	var busIndex = AudioServer.get_bus_index(MUSIC_BUS_NAME)
	AudioServer.set_bus_volume_db(busIndex, val)
	musicVol = val
	
	
func setSfxEnabled(val):
	sfxCheck.pressed = val
	var busIndex = AudioServer.get_bus_index(SFX_BUS_NAME)
	AudioServer.set_bus_mute(busIndex, !val)
	sfxEnabled = val
	
	
func setSfxVol(val):
	sfxVolSlider.value = val
	var busIndex = AudioServer.get_bus_index(SFX_BUS_NAME)
	AudioServer.set_bus_volume_db(busIndex, val)
	sfxVol = val


func _on_MainMenu_pressed():
	emit_signal("settings_main_menu")


func _on_MusicToggle_pressed():
	self.musicEnabled = musicCheck.pressed
	
	
func _on_MusicVolume_value_changed(value):
	self.musicVol = value


func _on_SfxToggle_pressed():
	self.sfxEnabled = sfxCheck.pressed


func _on_SfxVolume_value_changed(value):
	self.sfxVol = value
