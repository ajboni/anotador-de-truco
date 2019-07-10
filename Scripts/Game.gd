extends Control

# Declare member variables here. Examples:
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	# print($SettingsPanel.config.get_value("game","winning_score"))
	$Lanes/Nosotros/vContainer/Title.text = "Nosotros";
	$Lanes/Ellos/vContainer/Title.text = "Ellos";

func _on_Restart_button_pressed():
	$ResetGameConfirmation.popup()

func _on_ConfirmationDialog_confirmed():
	_restart_game();
	
func _restart_game():
	$Lanes/Ellos/crown.visible = false;
	$Lanes/Nosotros/crown.visible = false;
	if($SettingsPanel.visible):
		$SettingsPanel._on_Button_button_down()
	$Lanes/Ellos/vContainer/Score.restart()
	$Lanes/Nosotros/vContainer/Score.restart()
	Settings.winning_score = Settings.config.get_value("game", "winning_score")
	Settings.game_state = Settings.GAME_STATE.started;
	print("Starting a new game at: ", 	Settings.winning_score, " points")

func _on_OptionButton_item_selected(ID):
	var new_winning_score = $SettingsPanel/VBoxContainer/VBoxContainer/HBoxContainer/OptionButton.get("text")
	Settings.config.set_value("game","winning_score",int(new_winning_score))
	Settings.config.save("user://settings.cfg")

func _on_Back_button_pressed():
	$SettingsPanel._on_Button_button_down()