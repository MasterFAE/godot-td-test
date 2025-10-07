extends Node

@export var initial_coin := 100;

var current_coin := 0;

signal onCoinChange;

func collectCoin(amount: int):
	if(amount <= 0): return;
	current_coin += amount;
	onCoinChange.emit(current_coin)


func spendCoin(amount: int):
	if(amount <= 0): return;
	elif(amount > current_coin): return;
	current_coin -= amount;
	onCoinChange.emit(current_coin)
