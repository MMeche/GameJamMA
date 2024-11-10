extends Node

var museum_money: int = 0
var invest_made: bool
var flag_error: bool
var money_given: int = 0

var invest_mode: bool = false

func invest():
	var result = money_given * randi() % 10
	if randi() % 2: # == 1
		result *= -1
	museum_money += result + money_given
	money_given = 0
	return result
	
func update(money):
	if invest_mode && PlayerStats.player_money >= money:
		money_given += money
		PlayerStats.player_money -= money
	elif !invest_mode && money_given + museum_money > 0 :
		money_given -= money
		PlayerStats.player_money += money
	else:
		return true
	return false

# TODO
#	- saisir argent
