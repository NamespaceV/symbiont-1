extends Node
# SINGLETON G

var p1 : P1
var p2 : P2

var ammo = 5
var hp = 100.0

func deal_damage(damage:float):
	hp -= damage
	if hp < 0:
		fill_ammo()
		heal()
		get_tree().reload_current_scene()

func fill_ammo():
	G.ammo = max(G.ammo, 5)

func heal():
	G.hp = 100

func load_level(level_name):
	fill_ammo()
	heal()
	get_tree().change_scene_to_file("res://levels/"+level_name+".tscn")
