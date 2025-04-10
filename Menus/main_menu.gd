extends Node2D

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
	#var screen = DisplayServer.get_primary_screen()
	#OS.window_set_position(desired_position)
	
	#i want to get this to work but its being weird with my multiple monitors
	#get_window().position = Vector2i(2000, 750)
	
	mainMenu.visible = true
	tree.visible = true
	question.visible = false
	correct.visible = false
	wrong.visible = false
	
func _on_back_button_pressed() -> void:
	mainMenu.visible = true
	tree.visible = true
	question.visible = false
	leaderboard.visible = false
	

func _on_play_pressed() -> void:
	mainMenu.visible = false
	settings.visible = false
	question.visible = true
	tree.visible = false
	questionCounter += 1
	questionBox.text = " -= Question #" + str(questionCounter) + " =- "
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
		questionCounter += 1
		questionBox.text = " -= Question #" + str(questionCounter) + " =- "
		randomCoords()
	
var questionTotal = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28] #number of floors in that theme - 1 bc it starts at 0
var levels : int = questionTotal.size() #number of floors travelled before next theme
var levelLabelNumber : int = 0 #what should the levelLabel start at

func randomCoords():
	#when click play button, repopulate the second array that questions are removed from
	#already have one array for the toal number of questions
	#need to make second array with quesetion numbers
	#random number within indexes of second array
	#display quiestion at index of (idk which array)
	#remove from (idk which array)
	var inty : int = randi() % levels #levels 
	match questionTotal[inty]:
		0:
			questionLabel.text = "Who invented the light bulb?"
			name1.text = "Thomas Edison"
			name2.text = "George Washington"
			name3.text = "Willy Wonka"
			name4.text = "Jimbo"
			correctAnswer = 1
			categoryLabel.text = "History"
		1:
			questionLabel.text = "Who created Microsoft?"
			name1.text = "Barack Obama"
			name2.text = "Bill Gates"
			name3.text = "Steve Jobs"
			name4.text = "Jamieson Ford"
			correctAnswer = 2
			categoryLabel.text = "History"
		2:
			questionLabel.text = "What type of animal is the fast blue character, Sonic?"
			name1.text = "Shark"
			name2.text = "Bird"
			name3.text = "Velociraptor"
			name4.text = "Hedgehog"
			correctAnswer = 4
			categoryLabel.text = "Video Games"
		3:
			questionLabel.text = "Which food was created on accident?"
			name1.text = "Reese's Cups"
			name2.text = "M&M's"
			name3.text = "Grape"
			name4.text = "Potato Chips"
			correctAnswer = 4
			categoryLabel.text = "Food"
		4:
			questionLabel.text = "What was Ash Ketchum's first Pokemon?"
			name1.text = "Pikachu"
			name2.text = "Squirtle"
			name3.text = "Caterpie"
			name4.text = "Tauros"
			correctAnswer = 1
			categoryLabel.text = "Video Games"
		5:
			questionLabel.text = "What is Lightning McQueen's real name?"
			name1.text = "Dante"
			name2.text = "Lightning"
			name3.text = "Cruz"
			name4.text = "Montgomery"
			correctAnswer = 4
			categoryLabel.text = "Pop Culture"
		6:
			questionLabel.text = "What is the metal piece on the end of a shoelace called?"
			name1.text = "Ferrule"
			name2.text = "Aglet"
			name3.text = "Needle"
			name4.text = "Eyelet"
			correctAnswer = 2
			categoryLabel.text = "Pop Culture"
		7:
			questionLabel.text = "The 16th US President was Abraham Lincoln. Who was the 17th?"
			name1.text = "Abraham Lincoln"
			name2.text = "Andrew Johnson"
			name3.text = "Ulysses S. Grant"
			name4.text = "Rutherford B. Hayes"
			correctAnswer = 2
			categoryLabel.text = "History"
		8:
			questionLabel.text = "What is the densest planet in our solar system?"
			name1.text = "Mars"
			name2.text = "Neptune"
			name3.text = "Saturn"
			name4.text = "Earth"
			correctAnswer = 4
			categoryLabel.text = "Science"
		9:
			questionLabel.text = "How dangerous is the chemical dihydrogen monoxide to humans?"
			name1.text = "eh"
			name2.text = "kinda bad"
			name3.text = "EXTREMELY DANAGEROUS"
			name4.text = "not at all"
			correctAnswer = 4
			categoryLabel.text = "Science"
		10:
			questionLabel.text = "What video game duo specializes in plumbing?"
			name1.text = "Banjo & Kazooie"
			name2.text = "Sans & Papyrus"
			name3.text = "Zelda & Link"
			name4.text = "Mario & Luigi"
			correctAnswer = 4
			categoryLabel.text = "Video Games"
		11:
			questionLabel.text = "What animation studio created the character Lightning McQueen?"
			name1.text = "Disney Pixar"
			name2.text = "Studio Ghibli"
			name3.text = "DreamWorks"
			name4.text = "Aardman Animations"
			correctAnswer = 1
			categoryLabel.text = "Pop Culture"
		12:
			questionLabel.text = "What year was Thomas the Tank Engine created?"
			name1.text = "2003"
			name2.text = "1929"
			name3.text = "1942"
			name4.text = "1887"
			correctAnswer = 3
			categoryLabel.text = "Pop Culture"
		13:
			questionLabel.text = "When was Rosa Parks born?"
			name1.text = "2006"
			name2.text = "1903"
			name3.text = "1927"
			name4.text = "1913"
			correctAnswer = 4
			categoryLabel.text = "History"
		14:
			questionLabel.text = "Raleigh is the capital of which US State?"
			name1.text = "North Carolina"
			name2.text = "West Virginia"
			name3.text = "East Hawaii"
			name4.text = "South Dakota"
			correctAnswer = 1
			categoryLabel.text = "Geography"
		15:
			questionLabel.text = "Who is Batman's sidekick?"
			name1.text = "Albatross"
			name2.text = "Cardinal"
			name3.text = "Robin"
			name4.text = "Dodo"
			correctAnswer = 3
			categoryLabel.text = "Pop Culture"
		16:
			questionLabel.text = "When were TVs invented?"
			name1.text = "1927"
			name2.text = "1492"
			name3.text = "2008"
			name4.text = "2003"
			correctAnswer = 1
			categoryLabel.text = "History"
		17:
			questionLabel.text = "What is the name of the mouse in Stuart Little?"
			name1.text = "Rat"
			name2.text = "Remy"
			name3.text = "Stuart"
			name4.text = "Mickey"
			correctAnswer = 3
			categoryLabel.text = "Pop Culture"
		18:
			questionLabel.text = "What type of vehicle is Thomas the Tank Engine?"
			name1.text = "Car"
			name2.text = "Train"
			name3.text = "Boat"
			name4.text = "Truck"
			correctAnswer = 2
			categoryLabel.text = "Pop Culture"
		19:
			questionLabel.text = "In what year did Queen Elizabeth II pass away?"
			name1.text = "2029"
			name2.text = "2022"
			name3.text = "2014"
			name4.text = "2008"
			correctAnswer = 2
			categoryLabel.text = "History"
		20:
			questionLabel.text = "In what country did Thomas the Tank Engine first air?"
			name1.text = "France"
			name2.text = "New Zealand"
			name3.text = "United Kingdom"
			name4.text = "United States"
			correctAnswer = 3
			categoryLabel.text = "Pop Culture"
		21:
			questionLabel.text = "In the US & Canada, 1 ton is a unit of measure that contains how many pounds?"
			name1.text = "1,000 lbs"
			name2.text = "2,000 lbs"
			name3.text = "3,000 lbs"
			name4.text = "5,000 lbs"
			correctAnswer = 2
			categoryLabel.text = "Science"
		22:
			questionLabel.text = "The molecule \"hemoglobin\" is used in what type of blood cells?"
			name1.text = "White Blood Cells"
			name2.text = "Blue Blood Cells"
			name3.text = "Red Blood Cells"
			name4.text = "Goblin Blood Cells"
			correctAnswer = 3
			categoryLabel.text = "Science"
		23:
			questionLabel.text = "Penicillin was discovered in 1928 by which Scottish scientist?"
			name1.text = "Sir Alexander Flemming"
			name2.text = "Mary Queen of Scots"
			name3.text = "Robert Burns"
			name4.text = "James McAvoy"
			correctAnswer = 1
			categoryLabel.text = "Science"
		24:
			questionLabel.text = "The art of garden cultivation and management is called what?"
			name1.text = "Hortoculture"
			name2.text = "Gardenology"
			name3.text = "Plant-avation"
			name4.text = "Agriculture"
			correctAnswer = 1
			categoryLabel.text = "Science"
		25:
			questionLabel.text = "What is the name for the unit of measurement of power that is roughly equal to 746 watts?"
			name1.text = "Flowermight"
			name2.text = "Dogthrust"
			name3.text = "Yard"
			name4.text = "Horsepower"
			correctAnswer = 4
			categoryLabel.text = "Science"
		26:
			questionLabel.text = "What is the only internal organ in humans that is capable of regenerating lost tissue?"
			name1.text = "Pancreas"
			name2.text = "Kidney"
			name3.text = "Liver"
			name4.text = "Heart"
			correctAnswer = 3
			categoryLabel.text = "Science"
		27:
			questionLabel.text = "The reaction where two hydrogen atoms combine to form a helium atom is called what?"
			name1.text = "Fision"
			name2.text = "Confusion"
			name3.text = "Dilution"
			name4.text = "Fusion"
			correctAnswer = 4
			categoryLabel.text = "Science"
		28:
			questionLabel.text = "Approximately 2% of all people have what eye color?"
			name1.text = "Green"
			name2.text = "Purple"
			name3.text = "Blue"
			name4.text = "Hazel"
			correctAnswer = 1
			categoryLabel.text = "Science"
		29:
			questionLabel.text = "Who is the lil gay boy in BTS?"
			name1.text = "Jimin"
			name2.text = "JungleKock"
			name3.text = "V"
			name4.text = "Suga"
			correctAnswer = 1
			categoryLabel.text = "BTS"
		30:
			questionLabel.text = "Who is Worldwide Handsome?"
			name1.text = "Kyle Bazil Lastname(obviously)"
			name2.text = "Jin"
			name3.text = "Jack Black"
			name4.text = "Pitbull"
			correctAnswer = 1
			categoryLabel.text = "Facts"
		31:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		32:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		33:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		34:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		35:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		36:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		37:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		38:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		39:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		40:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		41:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		42:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		43:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		44:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		45:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		46:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		47:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		48:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		49:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
		50:
			questionLabel.text = ""
			name1.text = ""
			name2.text = ""
			name3.text = ""
			name4.text = ""
			correctAnswer = 4
			categoryLabel.text = ""
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
	var rotation = randf_range(0, 359)
	$Settings.rotation = rotation
	settings.visible = true

func _on_leaderboard_pressed() -> void:
	leaderboard.visible = true
	mainMenu.visible = false
	tree.visible = false
	settings.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()
	

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


	
