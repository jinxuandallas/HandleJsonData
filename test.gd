extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var a="test"
	var b={test=1,"dfdd":2}
	var c="xxxx"
	b.xxxx=3
	print(b)
	print(b[a])
	print(b[c])
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
