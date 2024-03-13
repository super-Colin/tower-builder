extends Node

signal askToAddBrick
signal addBrick

signal moneyUpdated
signal addMoney(amount: int)
signal removeMoney(amount: int)

signal stoneUpdated
signal addStone(amount: int)
signal removeStone(amount: int)

signal towerHeightUpdated
signal addTowerHeight(amount: int)
signal removeTowerHeight(amount: int)

signal toggleCameraFollowTower


signal earthEatenUpdated
signal addEarthEaten(amount: float)

signal setPlanetRadius(amount: int)



func _ready():
	# Emit the update signal after an add or remove signal  
	addMoney.connect(_addMoney)
	removeMoney.connect(_removeMoney)
	addStone.connect(_addStone)
	removeStone.connect(_removeStone)
	addTowerHeight.connect(_addTowerHeight)
	addEarthEaten.connect(_addEarthEaten)

func _addMoney(amount):
	Globals.money = Globals.money + amount
	moneyUpdated.emit()

func _removeMoney(amount):
	Globals.money = Globals.money - amount
	moneyUpdated.emit()



func _addStone(amount):
	Globals.stone = Globals.stone + amount
	stoneUpdated.emit()

func _removeStone(amount):
	Globals.stone = Globals.stone - amount
	stoneUpdated.emit()


func _addTowerHeight(amount):
	Globals.totalHeight = Globals.totalHeight + amount
	towerHeightUpdated.emit()

func _removeTowerHeight(amount):
	Globals.totalHeight = Globals.totalHeight - amount
	towerHeightUpdated.emit()



func _addEarthEaten(amount):
	if Globals.earthEaten > -1:
		Globals.earthEaten = Globals.earthEaten - amount
	#print("earth eaten")
	#print( Globals.earthEaten )
	earthEatenUpdated.emit()




