extends Node

var wallet = 0
var timeAdd = 0
var jumpHeightAdd = 0
var jumpAdd = 0
func addPick ():
	wallet += 1
	#print(wallet)
	
func getWallet():
	return wallet
func spend(amount: int):
	wallet -= amount
	pass
