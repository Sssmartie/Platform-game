extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var stuff = "In this life, you jumped " + str(Global.totaljump) + " times and collected " + str(Global.coin_count) + " coins"
	$Label2.text = stuff


func _on_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
