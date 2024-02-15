extends Node

signal askToAddBrick
signal addBrick
signal moneyUpdated
signal addMoney(amount: int)
signal removeMoney(amount: int)



func _ready():
	# Emit the update signal after an add or remove signal  
	addMoney.connect(_addMoney)
	removeMoney.connect(_removeMoney)



func _addMoney(amount):
	Globals.money = Globals.money + amount
	moneyUpdated.emit()

func _removeMoney(amount):
	Globals.money = Globals.money - amount
	moneyUpdated.emit()




