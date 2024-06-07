extends Node

const projectile_container : String = "projectile_container"
const melee_container : String = "melee_container"

func getProjectileContainer() -> Node2D:
	return get_tree().get_first_node_in_group(projectile_container)

func getMeleeContainer() -> Node2D: 
	return get_tree().get_first_node_in_group(melee_container)
