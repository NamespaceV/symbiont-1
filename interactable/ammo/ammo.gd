extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	var p = body as P1
	if p:
		G.ammo = max(G.ammo, 5)
	
