extends Node2D

@onready var title = $Title

# Declare nodes
@onready var question_label = $Question
@onready var answer_input = $AnswerInput
@onready var result_label = $ResultLabel
@onready var submit_button = $SubmitButton
@onready var challenger_sprite = $ChallengerSprite  

# Variables to hold the question details
var number1 = 0
var number2 = 0
var correct_answer = 0
var correctRight = 0
var is_addition = true  # Variable to track whether it's an addition or subtraction question

# Function to generate a random addition or subtraction question
func generate_question():
	number1 = randi() % 50  # Random number between 0 and 49
	number2 = randi() % 50  # Random number between 0 and 49
	# Randomly decide if the operation is addition or subtraction
	is_addition = randi() % 2 == 0  # 50% chance for addition or subtraction
	
	if is_addition:
		correct_answer = number1 + number2
		question_label.text = str(number1) + " + " + str(number2) + " = ?"
	else:
		# Ensure that number1 is greater than number2 for subtraction
		if number1 < number2:
			var tmp = number1
			number1 = number2
			number2 = tmp
			#number1, number2 = number2, number1  # Swap if necessary to avoid negative results
		correct_answer = number1 - number2
		question_label.text = str(number1) + " - " + str(number2) + " = ?"
	
	result_label.text = ""  # Clear previous result

# Function to check the answer
func check_answer():
	var user_answer = int(answer_input.text)
	if user_answer == correct_answer:
		result_label.text = "Correct!"
		title.text = "Get Ready for another question!"
		await get_tree().create_timer(3).timeout
		title.text = "Find the sum by adding or subtracting the following: "
		result_label.text = ""
		if correctRight > 5:
			correctRight = 0
			get_tree().change_scene_to_file("res://patterns.tscn")
		else:
			correctRight += 1
			_ready()
		
	else:
		result_label.text = "Try again!"
		await get_tree().create_timer(5).timeout
		result_label.text = ""

# Called when the scene is ready
func _ready():
	choose_random_name()
	generate_question()

# Function to pick a random name and display the challenge
func choose_random_name():
	var random_index = randi() % Global.names.size()  # Get a random index from the dictionary
	var person = Global.names[random_index]
	var name = person["name"]
	var gender = person["gender"]
	title.text = name + " challenges you to solve the following:"
	
	# Set the sprite image based on gender
	if gender == "Male":
		challenger_sprite.texture = load("res://images/boy.png")  # Set image for boys
		challenger_sprite.scale = Vector2(0.15, 0.15)  # Set scale for boy
	elif gender == "Female":
		challenger_sprite.texture = load("res://images/girl.png")  # Set image for girls
		challenger_sprite.scale = Vector2(0.06, 0.06)  # Set scale for girl

func _on_submit_button_pressed():
	check_answer()
