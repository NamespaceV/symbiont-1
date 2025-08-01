extends Control

@onready var label = $"Label"


func _process(_delta: float) -> void:
	label.text = "HP: %d Ammo: %d" % [G.hp, G.ammo]
