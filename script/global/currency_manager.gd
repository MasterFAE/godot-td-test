extends Node

@export var initial_coin : int = 1000;

var current_coin : int = self.initial_coin;

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


func canAfford(amount: int):
	return current_coin >= amount;
