extends Control

@onready var axe = $"../../Manager_Container/MeleeManager"
@onready var bullet_dmg_boost = $"../../Manager_Container/ProjectileManager"
@onready var main = $"../.."
@onready var player = $"../../Player" #prolly going to be used for axe and bullet only
@onready var player_as = $"../../Player/CharStateMachine/Alive"
@onready var player_skills = $"../../Player/Skills"
@onready var dash = $"../../Player/Skills/Dash"
@onready var hubris = $"../../Player/Skills/Hubris"
@onready var hack_away = $"../../Player/Skills/Hack n Slash"
@onready var run_n_gun = $"../../Player/Skills/Run n Gun"
@onready var vulture = $"../../Player/Skills/Vulture"

var as_cost = 30
var as_level = 0

func _ready():
	update_prices()

func update_prices():
	$ScrollContainer/VBoxContainer/Axe.text = "Axe Upgrade - " + str(axe.cost)
	$ScrollContainer/VBoxContainer/Bullet.text = "Bullet Upgrade - " + str(bullet_dmg_boost.cost)
	$ScrollContainer/VBoxContainer/Dash.text = "Dash - " + str(dash.cost)
	$"ScrollContainer/VBoxContainer/Run n Gun".text = "Run n Gun - " + str(run_n_gun.cost)
	$"ScrollContainer/VBoxContainer/Hack Away".text = "Hack Away - " + str(hack_away.cost)
	$ScrollContainer/VBoxContainer/Hubris.text = "Hubris - " + str(hubris.cost)
	$ScrollContainer/VBoxContainer/Vulture.text = "Vulture - " + str(vulture.cost)
	$"ScrollContainer/VBoxContainer/AS Upgrade".text = "Attack Speed Upgrade - " + str(as_cost)

func _on_exit_pressed():
	main.upgradeMenu()

func _on_axe_pressed():
	if (player.chocos >= axe.cost):
		player.chocos -= axe.cost
		axe.cost *= 1.8
		axe.dmg_boost += 5
		$ScrollContainer/VBoxContainer/Axe.text = "Axe Upgrade - " + str(int(axe.cost))


func _on_bullet_pressed():
	if (player.chocos >= bullet_dmg_boost.cost):
		player.chocos -= bullet_dmg_boost.cost
		bullet_dmg_boost.cost *= 1.8
		bullet_dmg_boost.damage_boost += 5
		$ScrollContainer/VBoxContainer/Bullet.text = "Bullet Upgrade - " + str(int(bullet_dmg_boost.cost))


func _on_dash_pressed():
	if (player.chocos >= dash.cost and !dash.unlocked): #one time upgrade
		player.chocos -= dash.cost
		dash.unlocked = true
		$ScrollContainer/VBoxContainer/Dash.text = "Dash - MAXED" 

func _on_run_n_gun_pressed():
	if (player.chocos >= run_n_gun.cost && run_n_gun.level < 5):
		player.chocos -= run_n_gun.cost
		run_n_gun.cost *= 1.8
		run_n_gun.level += 1
		$"ScrollContainer/VBoxContainer/Run n Gun".text = "Run n Gun - " + str(int(run_n_gun.cost))
		if (!run_n_gun.unlocked):
			run_n_gun.unlocked = true


func _on_hack_away_pressed():
	if (player.chocos >= hack_away.cost && hack_away.level < 5):
		player.chocos -= hack_away.cost
		hack_away.cost *= 1.8
		hack_away.level += 1
		$"ScrollContainer/VBoxContainer/Hack Away".text = "Hack Away - " + str(int(hack_away.cost))
		if (!hack_away.unlocked):
			hack_away.unlocked = true


func _on_hubris_pressed():
	if (player.chocos >= hubris.cost && hubris.level < 5):
		player.chocos -= hubris.cost
		hubris.cost *= 1.8
		hubris.level += 1
		$ScrollContainer/VBoxContainer/Hubris.text = "Hubris - " + str(int(hubris.cost))
		if (!hubris.unlocked):
			hubris.unlocked = true


func _on_vulture_pressed():
	if (player.chocos >= vulture.cost && vulture.level < 5):
		player.chocos -= vulture.cost
		vulture.cost *= 1.8
		vulture.level += 1
		$ScrollContainer/VBoxContainer/Vulture.text = "Vulture - " + str(int(vulture.cost))
		if (!vulture.unlocked):
			vulture.unlocked = true


func _on_as_upgrade_pressed():
	if (player.chocos >= as_cost && as_level < 5): #cahnge lines
		player_as.firerate_multiplier -= .03 #attack three percent faster
		player.chocos -= as_cost
		as_cost *= 1.8
		as_level += 1
		player_as.update_firerate()
		$"ScrollContainer/VBoxContainer/AS Upgrade".text = "Attack Speed Upgrade - " + str(int(as_cost))
