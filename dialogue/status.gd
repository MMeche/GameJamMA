extends Node

var museum_money: int = 0
var invest_made: bool
var flag_error: bool
var money_given: int = 0

var invest_mode: bool = false

func invest():
	var result = money_given * randi() % 20
	if randi() % 2: # == 1
		result *= -1
	museum_money += result + money_given
	money_given = 0
	return result
	
func update(money):
	if invest_mode && true: # TODO vérifier l'argent du joueur
		money_given += money
#		TODO retir sous joueur
	elif !invest_mode && money_given + museum_money > 0 :
		money_given -= money
#		TODO donner joueur
	else:
		return true
	return false

# TODO
#	1. que souhaitez vous faire ?
#		- ajouter
#		- retirer
#		- saisir argent
