extends Control
@onready var name_enter = $nameEnter

@onready var label = $Label
@onready var button = $Button
@onready var loading = $Loading

# Called when the node enters the scene tree for the first time.
func _ready():
	loading.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var text = name_enter.text.strip_edges()
	var key = text.to_int()
	if text == "":  # `strip_edges()` removes leading and trailing whitespace
		loading.text = "Is that a correct number? Try again!"
		loading.show()
		print("The text field is empty.")
	elif Global.names.has(key):
		print("Valid key! Name: ", Global.names[key])
		var welcome = "Welcome " + str(Global.names[key]['name'])
		loading.text = "Your Adventure is loading..."
		loading.show()
		name_enter.hide()
		label.text = welcome
		await wait_seconds(3)  # Wait for 3 seconds
		get_tree().change_scene_to_file("res://adding.tscn")  # Switch to the new scene
		
	else:
		loading.text = "Is that a correct number? Try again!"
		loading.show()
		print("The text field is empty.")
	
	
	
	#label.text = str(Global.studentNumber)
	#loading.show()
	#name_enter.hide()
	pass # Replace with function body.
	
	# Function to wait for a given number of seconds
func wait_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
