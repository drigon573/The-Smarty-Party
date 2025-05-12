extends Node

var mode : Modes
var strikes : int
var hasLeaderboard : bool
var currentScore : int
var maxQuestions : int
var filter : String

var currentMPlist : Array[Dictionary]
var currentTFlist : Array[Dictionary]
var scoreMultiplier : int

var playerName : String

enum Modes {
	FREEPLAY,	# Infinite questions with no limits.
	ENDLESS,	# Endless questions with 3 strikes.
	SPRINT		# Limited number of questions.
}

enum Categories {
	All,
	
	History,
	Science,
	Art,
	Math,
	Geography,
	
	Pop_Culture,
	Video_Games,
	Holidays
}

####################################################################################################

func startGame(pMode: Modes, pCatergory : Categories, _count : int = 20) -> void:
	mode = pMode
	strikes = 3 if pMode == Modes.ENDLESS else -1
	hasLeaderboard = pMode == Modes.ENDLESS || pMode == Modes.FREEPLAY
	currentScore = 0
	maxQuestions = _count
	filter = Categories.keys()[pCatergory]
	filter.replace('_', ' ')
	
	currentMPlist = multipleChoice.filter(matchesFilter)
	currentTFlist = trueAndFalse.filter(matchesFilter)
	scoreMultiplier = 1

func endGame(leaderboard : Leaderboard) -> void:
	if currentScore > 0 && !playerName.is_empty():
		leaderboard.maybeAddPlayersScore(playerName, currentScore)
	currentScore = 0

func getQuestion(labels : Array[Control]) -> int:
	var weight : float = 1.0 - float(currentTFlist.size()) / float(currentMPlist.size())
	print("TF Weight" + str(weight))
	if randf() <= weight:
		var currentMC : Dictionary = currentMPlist[randi() % currentMPlist.size()]
		labels[0].text = "Category: " + currentMC["category"]
		labels[1].text = currentMC["question"]
		var options : Array[String] = ["", "", "", ""]
		var seed : int = randi()
		for i in range(3):
			options[(seed + i)%4] = currentMC["incorrect"][(seed + i)%3]
		options[(seed + 3)%4] = currentMC["correct"]

		labels[2].text = options[0]
		labels[3].text = options[1]
		labels[4].text = options[2]
		labels[5].text = options[3]
		labels[4].show()
		labels[5].show()
		return (seed + 3)%4 + 1
	else:
		var currentTF : Dictionary = currentTFlist[randi() % currentTFlist.size()]
		labels[0].text = currentTF["category"]
		labels[1].text = currentTF["question"]
		labels[2].text = "True"
		labels[3].text = "False"
		labels[4].hide()
		labels[5].hide()
		return 1 if currentTF["correct"] else 2

func matchesFilter(item : Dictionary) -> bool:
	return item["category"] == filter || filter.begins_with("All")

func wrongAnswer() -> void: 
	scoreMultiplier = 1
	strikes -= 1

func rightAnswer() -> void: 
	scoreMultiplier *= 4
	currentScore += scoreMultiplier

####################################################################################################
const multipleChoice : Array[Dictionary] = [
	{
		"category":"History",
		"question":"Who invented the light bulb?",
		"correct":"Thomas Edison",
		"incorrect":["George Washington","Willy Wonka","Jimbo"]
	},
	{
		"category":"History",
		"question":"Who created Microsoft?",
		"correct":"Bill Gates",
		"incorrect":["Barack Obama","Steve Jobs","Jamieson Ford"]
	},
	{
		"category":"History",
		"question":"The 16th US President was Abraham Lincoln. Who was the 17th?",
		"correct":"Andrew Johnson",
		"incorrect":["Abraham Lincoln","Ulysses S. Grant","Rutherford B. Hayes"]
	},
	{
		"category":"History",
		"question":"When was Rosa Parks born?",
		"correct":"1913",
		"incorrect":["2006","1903","1927"]
	},
	{
		"category":"History",
		"question":"When were TVs invented?",
		"correct":"1927",
		"incorrect":["1492","2008","2003"]
	},
	{
		"category":"History",
		"question":"In what year did Queen Elizabeth II pass away?",
		"correct":"2022",
		"incorrect":["2029","2014","2008"]
	},
####################################################################################################
	{
		"category":"Science",
		"question":"What is the densest planet in our solar system?",
		"correct":"Earth",
		"incorrect":["Mars","Neptune","Saturn"]
	},
	{
		"category":"Science",
		"question":"How dangerous is the chemical dihydrogen monoxide to humans?",
		"correct":"Not at all",
		"incorrect":["Only to the lactose intolerant","Kinda bad","EXTREMELY DANAGEROUS"]
	},
	{
		"category":"Science",
		"question":"In the US & Canada, 1 ton is a unit of measure that contains how many pounds?",
		"correct":"2,000 lbs",
		"incorrect":["1,000 lbs","3,000 lbs","5,000 lbs"]
	},
	{
		"category":"Science",
		"question":"The molecule \"hemoglobin\" is used in what type of blood cells?",
		"correct":"Red Blood Cells",
		"incorrect":["White Blood Cells","Blue Blood Cells","Goblin Blood Cells"]
	},
	{
		"category":"Science",
		"question":"Penicillin was discovered in 1928 by which Scottish scientist?",
		"correct":"Sir Alexander Flemming",
		"incorrect":["Mary Queen of Scots","Robert Burns","James McAvoy"]
	},
	{
		"category":"Science",
		"question":"The art of garden cultivation and management is called what?",
		"correct":"Hortoculture",
		"incorrect":["Gardenology","Plant-avation","Agriculture"]
	},
	{
		"category":"Science",
		"question":"What is the name for the unit of measurement of power that is roughly equal to 746 watts?",
		"correct":"Horsepower",
		"incorrect":["Flowermight","Dogthrust","Yard"]
	},
	{
		"category":"Science",
		"question":"What is the only internal organ in humans that is capable of regenerating lost tissue?",
		"correct":"Liver",
		"incorrect":["Pancreas","Kidney","Heart"]
	},
	{
		"category":"Science",
		"question":"The reaction where two hydrogen atoms combine to form a helium atom is called what?",
		"correct":"Fusion",
		"incorrect":["Fision","Confusion","Dilution"]
	},
	{
		"category":"Science",
		"question":"Approximately 2% of all people have what eye color?",
		"correct":"Green",
		"incorrect":["Purple","Blue","Hazel"]
	},
####################################################################################################
	{
		"category":"Geography",
		"question":"Raleigh is the capital of which US State?",
		"correct":"North Carolina",
		"incorrect":["West Virginia","East Hawaii","South Dakota"]
	},
####################################################################################################
	{
		"category":"Pop Culture",
		"question":"What is Lightning McQueen's real name?",
		"correct":"Montgomery",
		"incorrect":["Dante","Lightning","Cruz"]
	},
	{
		"category":"Pop Culture",
		"question":"What is the metal piece on the end of a shoelace called?",
		"correct":"Aglet",
		"incorrect":["Ferrule","Needle","Eyelet"]
	},
	{
		"category":"Pop Culture",
		"question":"What animation studio created the character Lightning McQueen?",
		"correct":"Disney Pixar",
		"incorrect":["Studio Ghibli","DreamWorks","Aardman Animations"]
	},
	{
		"category":"Pop Culture",
		"question":"What year was Thomas the Tank Engine created?",
		"correct":"1942",
		"incorrect":["2003","1929","1887"]
	},
	{
		"category":"Pop Culture",
		"question":"Who is Batman's sidekick?",
		"correct":"Robin",
		"incorrect":["Albatross","Cardinal","Dodo"]
	},
	{
		"category":"Pop Culture",
		"question":"What type of vehicle is Thomas the Tank Engine?",
		"correct":"Train",
		"incorrect":["Car","Boat","Truck"]
	},
	{
		"category":"Pop Culture",
		"question":"In what country did Thomas the Tank Engine first air?",
		"correct":"United Kingdom",
		"incorrect":["France","New Zealand","United States"]
	},
####################################################################################################
	{
		"category":"Holidays",
		"question":"Who has a glowing red nose?",
		"correct":"Ruldolph",
		"incorrect":["Frosty","Hermey","Krampus"]
	},
####################################################################################################
	{
		"category":"Hidden",
		"question":"Are we going to get an A+?",
		"correct":"Yeah!",
		"incorrect":["No","I don't know","Eh"]
	}

]
####################################################################################################
####################################################################################################
####################################################################################################
const trueAndFalse : Array[Dictionary] = [
	{
		"category":"History",
		"question":"The Eath is flat.",
		"correct": false,
	},
		{
		"category":"History",
		"question":"George Washington cut down a cherry tree.",
		"correct": false,
	},
	{
		"category":"History",
		"question":"Apollo reached the moon on July 16, 1969.",
		"correct": true,
	},
	{
		"category":"History",
		"question":"Ludwig van Beethoven was deaf.",
		"correct": true,
	},
	####################################################################################################
	{
		"category":"Holidays",
		"question":"Candy canes were originally used to keep children quiet during church services.",
		"correct": true,
	},
	{
		"category":"Holidays",
		"question":"Halloween is on October 30th.",
		"correct": false,
	}
]
