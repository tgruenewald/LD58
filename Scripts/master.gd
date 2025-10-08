extends Node

var wallet = 0
var totalAccumulated = 0
var currentRound = 1
var timeAdd = 0
var jumpHeightAdd = 0
var jumpAdd = 0
var wallJump = false
var readyGo = false
var magnet = 1;
func addPick ():
	wallet += 1
	totalAccumulated += 1
	#print(wallet)
	
func getWallet():
	return wallet
func getTotalAccumulated():
	return totalAccumulated
func getCurrentRound():
	return currentRound
func incrementRound():
	currentRound += 1
func spend(amount: int):
	wallet -= amount
	pass
