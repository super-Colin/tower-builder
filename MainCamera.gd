extends Camera2D

var followTower = true


# Lower cap for the `_zoom_level`.
var min_zoom := 0.1
# Upper cap for the `_zoom_level`.
var max_zoom := 5.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
var zoom_factor := 0.1
# Duration of the zoom's tween animation.
var zoom_duration := 0.2

# The camera's target zoom level.
var _zoom_level := 1.0

#@onready var tween = create_tween()




# Called when the node enters the scene tree for the first time.
func _ready():
	Events.towerHeightUpdated.connect(centerOnTower)
	Events.toggleCameraFollowTower.connect(_toggleFollowTower)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		$'.'.position.x += direction * 10
	else:
		$'.'.position.x += direction * -10
	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		$'.'.position.y += direction * 10
	else:
		$'.'.position.y += direction * -10



func centerOnTower():
	pass
	#centerOnTowerHorizontal()
	#centerOnTowerVertical()


func centerOnTowerVertical():
	if followTower:
		$'.'.position.y = $"../Tower".brickHeight * (Globals.totalHeight - 5) * -1


func centerOnTowerHorizontal():
	if followTower:
		$'.'.position.x = $"../Tower".position.x





func _toggleFollowTower():
	#print("toggle follow tower")
	followTower = not followTower




func _set_zoom_level(value: float):
	# We limit the value between `min_zoom` and `max_zoom`
	_zoom_level = clamp(value, min_zoom, max_zoom)
	#print("zooming to ", _zoom_level)
	# Then, we ask the tween node to animate the camera's `zoom` property from its current value
	# to the target zoom level.
	#tween.interpolate_property(
		#self,
		#"zoom",
		#zoom,
		#Vector2(_zoom_level, _zoom_level),
		#zoom_duration,
		#tween.TRANS_SINE,
		## Easing out means we start fast and slow down as we reach the target value.
		#tween.EASE_OUT
	#)
	#tween.start()
	var tween = create_tween()
	tween.tween_property($'.', "zoom", Vector2(_zoom_level, _zoom_level), zoom_duration)
	await tween.finished




func _unhandled_input(event):
	if event.is_action_pressed("scroll_down"):
		#print("zooming in")
		_set_zoom_level(_zoom_level - zoom_factor)
	if event.is_action_pressed("scroll_up"):
		#print("zooming out")
		_set_zoom_level(_zoom_level + zoom_factor)
	#tween.tween_property($'.', "position", Vector2(0, 0), 1)




