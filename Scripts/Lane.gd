extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Settings.scores[self.name] = 0
	$crown.visible = false;	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Score_score_change():	
	Settings.add_score(self.name, $vContainer/Score.score);
	if($vContainer/Score.score >= Settings.winning_score):
		$crown.visible = true
	else:
		$crown.visible = false;
	
	