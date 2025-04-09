extends Control

var master_volume: int = 0
var music_volume: int = 0
var sfx_volume: int = 0
@onready var masterVolumeSlider = $"MarginContainer/VBoxContainer/Master Volume Slider"

func _ready():
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
