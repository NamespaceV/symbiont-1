extends Node2D

func hit():
	queue_free()
	G.queue_navmesh_update()
