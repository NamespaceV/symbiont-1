# SINGLETON G
extends Node

var p1 : P1
var p2 : P2

var ammo = 5
var hp = 100.0

var bake_timeout = 0.0

func _ready() -> void:
	Console.pause_enabled = true
	Console.add_command("l", load_level, ["level_name"])


func _physics_process(delta: float) -> void:
	bake_timeout -= delta

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

func queue_navmesh_update():
	if bake_timeout > 0:
		return
	bake_timeout = 0.09
	get_tree().create_timer(0.1).timeout.connect(func ():
		print("looking for navmeshes")
		var navmeshes = get_tree().get_root().find_children("*", "NavigationRegion2D", true, false)
		print("found ", navmeshes.size())
		for o in navmeshes:
			var n = (o as NavigationRegion2D)
			n.bake_navigation_polygon()
	)
