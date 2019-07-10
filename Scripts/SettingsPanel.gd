extends PopupPanel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var winning_score = 30
var config = ConfigFile.new()
var scores = {}
enum GAME_STATE { idle, started, finished }
var game_state = GAME_STATE.idle;

func _ready():
	var err = config.load("user://settings.cfg")
	if err == OK: # if not, something went wrong with the file loading
	    # Look for the display/width pair, and default to 1024 if missing
		winning_score = config.get_value("game", "winning_score", 30)	    	
		config.set_value("game", "winning_score", winning_score)	    			
		config.save("user://settings.cfg")	

func add_score(lane, value):
	scores[lane] = value;
	check_scores();

func check_scores():
	var have_a_winner = false;
	for i in scores:
		var score = scores[i];
		if (score >= winning_score):
			have_a_winner = true;	
	if(have_a_winner): 
		game_state = GAME_STATE.finished;
	else:
		game_state = GAME_STATE.started;

# Called when the node enters the scene tree for the first time.


	#$VBoxContainer/HBoxContainer/OptionButton.set(
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	pass # Replace with function body.


func _on_Button_button_down():
	if(visible):
		pass
		visible = false
	else:
		popup()
