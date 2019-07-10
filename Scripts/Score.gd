extends VBoxContainer


var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():	
	_update_ui()	

signal score_change()

func restart():
	score = 0
	clear_ui()
	_update_ui()

func _on_substractScore_pressed():
	if(score == 0): return

	# Only allow substraction on game end if we take it away from winning lane
	if(Settings.game_state == Settings.GAME_STATE.finished && score != Settings.winning_score ):
		return;
	score = score -1 
	_update_ui()

func _on_addScore_pressed():

	if(Settings.game_state == Settings.GAME_STATE.finished):
		var popup = get_node("../../../../ResetGameConfirmation");
		popup.popup();
		return;

	if(score == Settings.winning_score): 
		print("TODO: WIN")
		return	

	score = score +1 
	_update_ui()	

func clear_ui(): 
	$ScoreItem1.play("0")
	$ScoreItem2.play("0")
	$ScoreItem3.play("0")
	$ScoreItem4.play("0")
	$ScoreItem5.play("0")
	$ScoreItem6.play("0")

func _update_ui(): 	

	# Only use "Malas" lane if we chose 15 or 12 points.
	var dividend = 6;
	if(Settings.winning_score <= 15): dividend = 3;

	var item_max_score = Settings.winning_score / dividend;
	var full = score / item_max_score;
	var mod = score % item_max_score;	
	# print(full, "--",mod)
	
	var array = []
	array.push_back($ScoreItem1)
	array.push_back($ScoreItem2)
	array.push_back($ScoreItem3)
	array.push_back($ScoreItem4)
	array.push_back($ScoreItem5)
	array.push_back($ScoreItem6)
	var x = 0
	while x < full:
		var score_item : ScoreItem = array[x]
		score_item.play(String(item_max_score))		
		# print(x)
		x += 1
	
	emit_signal("score_change")
	
	if(score >= Settings.winning_score):
		$HBoxContainer/Lane_Buttons/addScore.disabled = true;
		return
	elif(score < Settings.winning_score):
		$HBoxContainer/Lane_Buttons/addScore.disabled = false;		
	elif(score <= 0):
		$HBoxContainer/Lane_Buttons/substractScore.disabled = true;
		return		
	elif(score > 0):
		$HBoxContainer/Lane_Buttons/substractScore.disabled = false;			
		
	var score_item : ScoreItem = array[x]
	score_item.play(String(mod))
	
func _on_background_pressed():
	_on_addScore_pressed()
	pass # Replace with function body.
