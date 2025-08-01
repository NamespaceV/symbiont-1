# SINGLETON G
extends Node

var p1 : P1
var p2 : P2

var ammo = 5
var hp = 100.0

var bake_timeout = 0.0

var input_debug = false

func _ready() -> void:
	Console.pause_enabled = true
	Console.add_command("l", load_level, ["level_name"])
	Console.add_command("input_debug", toggle_input_debug)
	Console.add_command("input_remap", input_remap,  ["player", "device_nr"])
	


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

func toggle_input_debug():
	input_debug = !input_debug

func _input(event):
	if !input_debug: return
	if event is InputEventJoypadButton and event.pressed:
		var device_id = event.device
		var device_name = Input.get_joy_name(device_id)
		print("Input from device id ", device_id, ": ", device_name)

func input_remap(pl, device):
	for type in ["l","r", "u", "d", "a"]:
		for event in InputMap.action_get_events("p"+pl+"_"+type):
			if event.device != -1:
				event.device = int(device)
