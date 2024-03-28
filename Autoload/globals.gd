extends Node

var config
var path_to_file := "user://game.cfg"
var section_name := "game"

var gold = 5000
var starts_n = 0
var deaths_n : int = 0
var collects_n_h = 0
var saves_n = 0
var player1_name : String

var last_level : String = ""

var buyable_items = {
	#0: {
		#"Name": "Apples",
		#"Des": "Это просто яблочкиииии!",
		#"Cost": 10
	#},
	#1: {
		#"Name": "Bananas",
		#"Des": "Это просто бананчикиииии!",
		#"Cost": 100
	#},
	#2: {
		#"Name": "Cherry",
		#"Des": "Это просто вишенкииииии!",
		#"Cost": 1000
	#},
	#3: {
		#"Name": "Kiwi",
		#"Des": "Это просто Кивиииииии!",
		#"Cost": 1200
	#},
	0: {
		"Name": "Dash",
		"Des": "Способность сделать рывок. Ты получил её за прохождение до этого момента!",
		"Cost": 0
	},
}

#var inventory = {
#0: {
	#"Name": "Apples",
	#"Des": "Это просто яблочкиииии!",
	#"Cost": 10,
	#"Count": 1
	#},
#3: {
		#"Name": "Kiwi",
		#"Des": "Это просто Кивиииииии!",
		#"Cost": 1200,
		#"Count": 1
	#},
#}

func _ready() -> void:
	#print("golbals.gd автоматически загружен!")
	load_game()
	starts_n += 1

func save_game() -> void:
	saves_n += 1
	config.set_value(section_name, "player_name", player1_name)
	config.set_value(section_name, "starts_n", starts_n)
	config.set_value(section_name, "deaths_n", deaths_n)
	config.set_value(section_name, "gold", gold)
	config.set_value(section_name, "collects_n_h", collects_n_h)
	config.set_value(section_name, "saves_n", saves_n)
	config.set_value(section_name, "last_level", last_level)
	config.save(path_to_file)

func load_game() -> void:
	config = ConfigFile.new()
	config.load(path_to_file)
	player1_name = config.get_value(section_name, "player_name", "Игрок1")
	starts_n = config.get_value(section_name, "starts_n", 0)
	deaths_n = config.get_value(section_name, "deaths_n", 0)
	gold = config.get_value(section_name, "gold", 5000)
	collects_n_h = config.get_value(section_name, "collects_n_h", 0)
	saves_n = config.get_value(section_name, "saves_n", 0)
	last_level = config.get_value(section_name, "last_level", "")
