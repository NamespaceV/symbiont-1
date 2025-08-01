extends Node
# SINGLETON G

var p1 : P1
var p2 : P2

var ammo = 5
var hp = 100.0

func deal_damage(damage:float):
	hp -= damage
