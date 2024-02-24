extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.earthEatenUpdated.connect(_eatEarth)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass






func _eatEarth():
	#$EarthParallaxBackground/EarthParallaxLayer/Substrate.material.set_shader_parameter('value', Globals.earthEaten)
	$EarthParallaxBackground/EarthParallaxLayer2/Substrate.material.set_shader_parameter('value', Globals.earthEaten)








