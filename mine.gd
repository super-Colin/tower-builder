extends Area2D

var mouseUp = false






# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _input_event(viewport, event, intt):
	if event is InputEventMouseButton and event.pressed:
		if mouseUp:
			Events.addStone.emit(7)
		mouseUp = !mouseUp
		#print("button pressed ", event)








