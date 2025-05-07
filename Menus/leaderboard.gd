extends Control

@onready var items : GridContainer = $ItemList/MarginContainer/GridContainer
const SAVE_PATH = "user://sm_local_leaderboard.save"

var leaderboard : Dictionary = {
	"name_one": "",
	"name_two": "",
	"name_three": "",
	"name_four": "",
	"name_five": "",
	"score_one": 0,
	"score_two": 0,
	"score_three": 0,
	"score_four": 0,
	"score_five": 0,
}

func _ready() -> void:
	self.visibility_changed.connect(load)

func _process(delta: float) -> void:
	pass

func load() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		leaderboard.clear()
		leaderboard = JSON.parse_string(file.get_as_text())
		$ItemList/MarginContainer/GridContainer/Name1.text = leaderboard.get("name_one")
		$ItemList/MarginContainer/GridContainer/Name2.text = leaderboard.get("name_two")
		$ItemList/MarginContainer/GridContainer/Name3.text = leaderboard.get("name_three")
		$ItemList/MarginContainer/GridContainer/Name4.text = leaderboard.get("name_four")
		$ItemList/MarginContainer/GridContainer/Name5.text = leaderboard.get("name_five")
		
		$ItemList/MarginContainer/GridContainer/Score1.text = str(leaderboard.get("score_one"))
		$ItemList/MarginContainer/GridContainer/Score2.text = str(leaderboard.get("score_two"))
		$ItemList/MarginContainer/GridContainer/Score3.text = str(leaderboard.get("score_three"))
		$ItemList/MarginContainer/GridContainer/Score4.text = str(leaderboard.get("score_four"))
		$ItemList/MarginContainer/GridContainer/Score5.text = str(leaderboard.get("score_five"))
	else:	
		save()
	
func save()  -> void:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_string(JSON.stringify(leaderboard))
