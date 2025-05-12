extends Control
class_name Settings

const SAVE_PATH = "user://sm_local_settings.save"
var player_name : String

var master_volume : float = 0
var music_volume : float = 0
var sfx_volume : float = 0
@onready var masterVolumeSlider = $"MarginContainer/VBoxContainer/Master Volume Slider"

func _ready():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var settings : Dictionary
		settings = JSON.parse_string(file.get_as_text())
		
		player_name = settings.get("name")
		QuizHandler.playerName = player_name
		master_volume = settings.get("master volume")
		music_volume = settings.get("music volume")
		sfx_volume = settings.get("sfx volume")
	
	$".".visible = false
	#sets value of slider to match volume value
	$"MarginContainer/VBoxContainer/Master Volume Slider".set_value(master_volume)
	$"MarginContainer/VBoxContainer/Music Volume Slider".set_value(music_volume)
	$"MarginContainer/VBoxContainer/SFX Music Slider".set_value(sfx_volume)

func _physics_process(delta: float) -> void:
	if($".".visible):
		$"MarginContainer/VBoxContainer/Master Volume/Master Volume Label".text = str(master_volume)
		$"MarginContainer/VBoxContainer/Music Volume/Music Volume Label".text = str(music_volume)
		$"MarginContainer/VBoxContainer/SFX Music/SFX Music Label".text = str(sfx_volume)

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0,value) #the 0 means the Master Bus
	#actually changes volume
	master_volume = value

func _on_music_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value) #the 1 means the Music Bus
	#actually changes volume
	music_volume = value

func _on_sfx_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value) #the 2 means the Ambient Bus
	#actually changes volume
	sfx_volume = value

func _on_check_box_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0, $MarginContainer/VBoxContainer/CheckBox.button_pressed)

func _on_return_to_main_menu_pressed() -> void:
	$".".visible = false

func _on_tree_exiting() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var settings : Dictionary
	settings.get_or_add("name", player_name)
	settings.get_or_add("master volume", master_volume)
	settings.get_or_add("music volume", music_volume)
	settings.get_or_add("sfx volume", sfx_volume)

	file.store_string(JSON.stringify(settings))
