extends Control

@onready var label = $"Label"


func _process(_delta: float) -> void:
	label.text = "HP: %d \t Ammo: %d \t Enemies: %d" % [G.hp, G.ammo, G.enemies_alive]
