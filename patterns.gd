extends Node2D

# Declare UI nodes using the @onready keyword
@onready var pattern_label = $PatternLabel
@onready var input_field = $AnswerInput
@onready var submit_button = $SubmitButton
@onready var result_label = $ResultLabel
@onready var title = $Title
@onready var challenger_sprite = $ChallengerSprite

# Variables to store the pattern and correct answer
var pattern = []
var correct_answer = ""

var correctRight = 0

# Function to generate a random growing pattern
func generate_growing_pattern():
	var start_number = randi() % 50 + 1  # Random starting number between 1 and 50
	var step = randi() % 5 + 1  # Random step between 1 and 5
	pattern.clear()

	for i in range(5):  # Generate 5 numbers in the pattern
		pattern.append(start_number + i * step)

	# Generate the next two numbers for the growing pattern
	var next1 = pattern[4] + step
	var next2 = next1 + step

	# Set the correct answer
	correct_answer = str(next1) + "," + str(next2)

	# Display the pattern
	pattern_label.text = "Growing pattern: " + str(pattern) + ", __, __. \n
What are the next two numbers?\nEnter the numbers like: 3,4"

# Function to generate a random shrinking pattern
func generate_shrinking_pattern():
	var start_number = randi() % 50 + 50  # Random starting number between 50 and 100
	var step = randi() % 5 + 1  # Random step between 1 and 5
	pattern.clear()

	for i in range(5):  # Generate 5 numbers in the pattern
		pattern.append(start_number - i * step)

	# Generate the next two numbers for the shrinking pattern
	var next1 = pattern[4] - step
	var next2 = next1 - step

	# Set the correct answer
	correct_answer = str(next1) + "," + str(next2)

	# Display the pattern
	pattern_label.text = "Shrinking pattern: " + str(pattern) + ", __, __. 
	\nWhat will the next two numbers be?\nEnter the numbers like: 3,4"

# Function to check the user's answer
func check_answer():
	var user_answer = input_field.text.strip_edges()
	
	if user_answer == correct_answer:
		result_label.text = "Correct!"
		pattern_label.text = "Correct! Get ready for the next one!"
		await get_tree().create_timer(3).timeout
		print("correctedRight:"+str(correctRight))
		if correctRight > 5:
			correctRight = 0
			get_tree().change_scene_to_file("res://adding.tscn")
			input_field.text = ""
		else:
			correctRight += 1
			_ready()
	else:
		result_label.text = "Try again!"
		await get_tree().create_timer(5).timeout
		result_label.text = ""

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
		
# Called when the scene is ready
func _ready():
	# Seed the random number generator
	randomize()

	choose_random_name()
	
	# Randomly choose between growing or shrinking pattern
	if randi() % 2 == 0:
		generate_growing_pattern()  # 50% chance to generate a growing pattern
	else:
		generate_shrinking_pattern()  # 50% chance to generate a shrinking pattern

	# Connect the button to check the answer
	


func _on_submit_button_pressed():
	check_answer()
	pass # Replace with function body.
