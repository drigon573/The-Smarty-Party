extends Control

@onready var items : GridContainer = $ItemList/MarginContainer/GridContainer
const SAVE_PATH = "user://sm_local_leaderboard.save"

var leaderboard : Dictionary = {
	"names" :{
		"name_one": "",
		"name_two": "",
		"name_three": "",
		"name_four": "",
		"name_five": ""
	},
	"scores": {
		"score_one": 0,
		"score_two": 0,
		"score_three": 0,
		"score_four": 0,
		"score_five": 0
	}
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
		
		var names: Dictionary = leaderboard.get("names")
		$ItemList/MarginContainer/GridContainer/Name1.text = names.get("name_one")
		$ItemList/MarginContainer/GridContainer/Name2.text = names.get("name_two")
		$ItemList/MarginContainer/GridContainer/Name3.text = names.get("name_three")
		$ItemList/MarginContainer/GridContainer/Name4.text = names.get("name_four")
		$ItemList/MarginContainer/GridContainer/Name5.text = names.get("name_five")
		
		var scores: Dictionary = leaderboard.get("scores")
		$ItemList/MarginContainer/GridContainer/Score1.text = str(scores.get("score_one"))
		$ItemList/MarginContainer/GridContainer/Score2.text = str(scores.get("score_two"))
		$ItemList/MarginContainer/GridContainer/Score3.text = str(scores.get("score_three"))
		$ItemList/MarginContainer/GridContainer/Score4.text = str(scores.get("score_four"))
		$ItemList/MarginContainer/GridContainer/Score5.text = str(scores.get("score_five"))
	else:	
		save()

func save() -> void:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_string(JSON.stringify(leaderboard))

func maybeAddPlayersScore(name: String, score: int) -> void:
	var sub = 0
	var scores: Dictionary = leaderboard.get("scores")
	var players: Dictionary = leaderboard.get("names")
	var score_names = scores.keys()
	var player_names = players.keys()

	for i in scores.values():
		if score >= i:
			for n in range(4-sub):
				
				scores[score_names[4-n]] = scores[score_names[3-n]]
				players[player_names[4-n]] = players[player_names[3-n]]
			scores[score_names[sub]] = score
			players[player_names[sub]] = name
			save()
			return
		sub += 1
