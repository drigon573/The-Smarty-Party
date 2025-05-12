extends Node2D
class_name MainMenu

@onready var mainMenu = $"Main Menu"
@onready var settings = $Settings
@onready var leaderboard = $Leaderboard
@onready var question = $Question

@onready var questionLabel = $Question/ItemList/MarginContainer/GridContainer/Question
@onready var name1 = $Question/ItemList/MarginContainer/GridContainer/Name1
@onready var name2 = $Question/ItemList/MarginContainer/GridContainer/Name2
@onready var name3 = $Question/ItemList/MarginContainer/GridContainer/Name3
@onready var name4 = $Question/ItemList/MarginContainer/GridContainer/Name4
@onready var submit = $Question/ItemList/MarginContainer/GridContainer/Submit
@onready var correct = $Question/Correct
@onready var correctPlayer = $"Question/Correct/Correct Player"
@onready var wrong = $Question/Incorrect
@onready var wrongPlayer = $"Question/Incorrect/Wrong Player"
@onready var questionBox = $Question/Label
@onready var tree = $"Main Menu/Pngtree-isolated-ginko-tree-png-png-image6095192"
@onready var categoryLabel = $"Question/Category Label"

@onready var correctAnswer
@onready var questionCounter: int = 0

func _ready() -> void:
	#leaderboard.maybeAddPlayersScore("Smarty", 9999)
	#leaderboard.maybeAddPlayersScore("Arty", 600)
	#leaderboard.maybeAddPlayersScore("James", 40)
	#leaderboard.maybeAddPlayersScore("Marty", 15)
	#leaderboard.maybeAddPlayersScore("Johnny", 10)
	#leaderboard.maybeAddPlayersScore("Test", 5)
	#leaderboard.maybeAddPlayersScore("01234567890123456789", 789)
	#leaderboard.maybeAddPlayersScore("Test3", 456)
	#leaderboard.maybeAddPlayersScore("Test4", 83)

	#var screen = DisplayServer.get_primary_screen()
	#OS.window_set_position(desired_position)
	
	#i want to get this to work but its being weird with my multiple monitors
	#get_window().position = Vector2i(2000, 750)
	
	mainMenu.visible = true
	tree.visible = true
	question.visible = false
	correct.visible = false
	wrong.visible = false
	$"Main Menu/NameEdit".text = settings.player_name
	
func _on_back_button_pressed() -> void:
	if question.visible:
		QuizHandler.endGame($Leaderboard)
		questionCounter = 0
	mainMenu.visible = true
	tree.visible = true
	question.visible = false
	leaderboard.visible = false
	

func _on_play_pressed() -> void:
	mainMenu.visible = false
	settings.visible = false
	question.visible = true
	tree.visible = false
	QuizHandler.startGame(QuizHandler.Modes.FREEPLAY, QuizHandler.Categories.All)
	questionCounter += 1
	questionBox.text = " -= Question #" + str(questionCounter) + " =- "
	$Question/Score.text = "Score: " + str(QuizHandler.currentScore)
	randomCoords()

func _on_submit_pressed() -> void:
	#check if a button is pressed
	var userAnswer
	if(name4.button_pressed || name3.button_pressed || name2.button_pressed || name1.button_pressed):
		#check what button is pressed
		if(name1.button_pressed):
			userAnswer = 1
		if(name2.button_pressed):
			userAnswer = 2
		if(name3.button_pressed):
			userAnswer = 3
		if(name4.button_pressed):
			userAnswer = 4
		#check the text of what button is pressed
		if(userAnswer == correctAnswer):
			QuizHandler.rightAnswer()
			correct.visible = true
			correctPlayer.play()
			await get_tree().create_timer(2).timeout
			correct.visible = false
		else:
			QuizHandler.wrongAnswer()
			wrong.visible = true
			wrongPlayer.play()
			await get_tree().create_timer(3).timeout
			wrong.visible = false
			if QuizHandler.strikes == 0:
				_on_back_button_pressed()
		
		#deselect selected button
		name1.button_pressed = false
		name2.button_pressed = false
		name3.button_pressed = false
		name4.button_pressed = false
		#next question
		questionCounter += 1
		questionBox.text = " -= Question #" + str(questionCounter) + " =- "
		$Question/Score.text = "Score: " + str(QuizHandler.currentScore)
		randomCoords()
	
var questionTotal = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28] #number of floors in that theme - 1 bc it starts at 0
var levels : int = questionTotal.size() #number of floors travelled before next theme
var levelLabelNumber : int = 0 #what should the levelLabel start at

func randomCoords():
	correctAnswer = QuizHandler.getQuestion([categoryLabel, questionLabel, name1, name2, name3, name4])
	print("Correct: " + str(correctAnswer))
	return 
	#when click play button, repopulate the second array that questions are removed from
	#already have one array for the toal number of questions
	#need to make second array with quesetion numbers
	#random number within indexes of second array
	#display quiestion at index of (idk which array)
	#remove from (idk which array)
	var inty : int = randi() % levels #levels 
	removey(inty)

func removey(inty):
	levels -= 1
	levelLabelNumber +=1
	if(levels > 0):
		questionTotal.remove_at(inty)
	else:
		print("poggers")
		mainMenu.visible = true
		tree.visible = true
		question.visible = false
		leaderboard.visible = false

func _on_settings_pressed() -> void:
	#rotatino was set to 10.3
	settings.visible = true
	var rotation = randf_range(0, 359)
	$Settings.rotation = rotation
	#while(settings.visible == true):
		#await get_tree().create_timer(1).timeout
		##continuously rotate
		##$Settings.rotation += .5
		##randomly change rotation
		#var rotation = randf_range(0, 359)
		#$Settings.rotation = rotation
	

func _on_leaderboard_pressed() -> void:
	leaderboard.visible = true
	mainMenu.visible = false
	tree.visible = false
	settings.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_line_edit_text_changed(new_text: String) -> void:
	QuizHandler.playerName = new_text
	settings.player_name = new_text
