extends Node2D

@onready var question = $Question/ItemList/MarginContainer/GridContainer/Question
@onready var name1 = $Question/ItemList/MarginContainer/GridContainer/Name1
@onready var name2 = $Question/ItemList/MarginContainer/GridContainer/Name2
@onready var name3 = $Question/ItemList/MarginContainer/GridContainer/Name3
@onready var name4 = $Question/ItemList/MarginContainer/GridContainer/Name4
@onready var submit = $Question/ItemList/MarginContainer/GridContainer/Submit
@onready var correct = $Question/Correct
@onready var correctPlayer = $"Question/Correct/Correct Player"
@onready var wrong = $Question/Incorrect
@onready var wrongPlayer = $"Question/Incorrect/Wrong Player"

@onready var correctAnswer

func _ready() -> void:
	$"Main Menu".visible = true
	$Question.visible = false
	correct.visible = false
	wrong.visible = false
	
func _on_back_button_pressed() -> void:
	$"Main Menu".visible = true
	$Question.visible = false

func _on_play_pressed() -> void:
	$"Main Menu".visible = false
	$Question.visible = true
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
			correct.visible = true
			correctPlayer.play()
			await get_tree().create_timer(2).timeout
			correct.visible = false
		else:
			wrong.visible = true
			wrongPlayer.play()
			await get_tree().create_timer(3).timeout
			wrong.visible = false
		#deselect selected button
		name1.button_pressed = false
		name2.button_pressed = false
		name3.button_pressed = false
		name4.button_pressed = false
		#next question
		randomCoords()
	
var questionTotal = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9] #number of floors in that theme - 1 bc it starts at 0
var levels : int = questionTotal.size() #number of floors travelled before next theme
var levelLabelNumber : int = 0 #what should the levelLabel start at

func randomCoords():
	var inty : int = randi() % levels #levels 
	match questionTotal[inty]:
		0:
			question.text = "Who invented the light bulb?"
			name1.text = "Thomas Edison"
			name2.text = "George Washington"
			name3.text = "Willy Wonka"
			name4.text = "Jimbo"
			correctAnswer = 1
		1:
			question.text = "Who created Microsoft?"
			name1.text = "Barack Obama"
			name2.text = "Bill Gates"
			name3.text = "Steve Jobs"
			name4.text = "Jamieson Ford"
			correctAnswer = 2
		2:
			question.text = "What type of animal is the fast blue character, Sonic?"
			name1.text = "Shark"
			name2.text = "Bird"
			name3.text = "Velociraptor"
			name4.text = "Hedgehog"
			correctAnswer = 4
		3:
			question.text = "Which food was created on accident?"
			name1.text = "Reese's Cups"
			name2.text = "M&M's"
			name3.text = "Grape"
			name4.text = "Potato Chips"
			correctAnswer = 4
		4:
			question.text = "What was Ash Ketchum's first Pokemon?"
			name1.text = "Pikachu"
			name2.text = "Squirtle"
			name3.text = "Caterpie"
			name4.text = "Tauros"
			correctAnswer = 1
		5:
			question.text = "What is Lightning McQueen's real name?"
			name1.text = "Dante"
			name2.text = "Lightning"
			name3.text = "Cruz"
			name4.text = "Montgomery"
			correctAnswer = 4
		6:
			question.text = "What is the metal piece on the end of a shoelace called?"
			name1.text = "Ferrule"
			name2.text = "Aglet"
			name3.text = "Needle"
			name4.text = "Eyelet"
			correctAnswer = 2
		7:
			question.text = "The 16th US President was Abraham Lincoln. Who was the 17th?"
			name1.text = "Abraham Lincoln"
			name2.text = "Andrew Johnson"
			name3.text = "Ulysses S. Grant"
			name4.text = "Rutherford B. Hayes"
			correctAnswer = 2
		8:
			question.text = "What is the densest planet in our solar system?"
			name1.text = "Mars"
			name2.text = "Naptune"
			name3.text = "Saturn"
			name4.text = "Earth"
			correctAnswer = 4
		9:
			question.text = "How dangerous is the chemical dihydrogen monoxide to humans?"
			name1.text = "eh"
			name2.text = "kinda bad"
			name3.text = "EXTREMELY DANAGEROUS"
			name4.text = "not at all"
			correctAnswer = 4
	removey(inty)

func removey(inty):
	levels -= 1
	levelLabelNumber +=1
	questionTotal.remove_at(inty)

#func disbaleExit():
	#if !Globals.hasPlayerVisitedMinesYet:
		#if(levelLabelNumber == 4):
			##$Player/Dialogue.displayDialogue(9, 10, 2)
			#$Player/"Player Hud"/Dialogue.displayDialogue(
				#["I should leave, nobody's down here."],["johnny"],["serious"], 0)
#
			#$ExitLadders.process_mode = Node.PROCESS_MODE_DISABLED
			#await get_tree().create_timer(2.5).timeout
			#$ExitLadders.process_mode = Node.PROCESS_MODE_INHERIT
			#print("exit enabled")
		#elif(levelLabelNumber == 5): #kicks the player out of the mines if they try to go down more than 4 floors
			#print("yes")
			#Globals.playerPositionX = 2682
			#Globals.playerPositionY = 534
			#Globals.previousScene = Globals.currentScene
			#get_tree().change_scene_to_file(MountHaven)
		#else:
			##print("levels is: " + str(levels))
			#print("exit disbaled")
			#$ExitLadders.process_mode = Node.PROCESS_MODE_DISABLED
			#await get_tree().create_timer(2.5).timeout
			#$ExitLadders.process_mode = Node.PROCESS_MODE_INHERIT
			#print("exit enable")
	#else: #player has visited mines before and gone back to the town, making Globals.hasPlayerVisitedMinesYet = true
		#if(levels <= 0): #to make it so that once you have entered enough floors, you get sent to the final boos floor
			#Globals.previousScene = Globals.currentScene
			#get_tree().change_scene_to_file(minesTheme2)
		#else:
			##print("levels is: " + str(levels))
			##print("exit disbaled")
			#$ExitLadders.process_mode = Node.PROCESS_MODE_DISABLED
			#await get_tree().create_timer(2.5).timeout
			#$ExitLadders.process_mode = Node.PROCESS_MODE_INHERIT
			##print("exit enable")


	
