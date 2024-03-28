extends CanvasLayer

var currItem = 0
var select = 0

func _on_close_pressed() -> void:
	get_tree().paused = false
	get_node("Anim").play("TransOut")
	


func switchItem(select):
	for i in range(Globals.buyable_items.size()):
		if select == i:
			currItem = select
			get_node("Control/AnimSprite").play(Globals.buyable_items[currItem]["Name"])
			get_node("Control/Name").text = Globals.buyable_items[currItem]["Name"]
			get_node("Control/Description").text = Globals.buyable_items[currItem]["Des"]
			get_node("Control/Description").text += "\nЦена: " + str(Globals.buyable_items[currItem]["Cost"])

#func _on_next_pressed() -> void:
	#switchItem(currItem+1)
	#if currItem == 4:
		#$Control/GetDash.visible = true
		#$Control/Buy.visible = false
		#if GlobalVars.player_dashfunc == true:
			#$Control/GetDash.visible = false
#
#func _on_prev_pressed() -> void:
	#switchItem(currItem-1)
	#if currItem != 4:
		#$Control/GetDash.visible = false
		#$Control/Buy.visible = true
		#if GlobalVars.player_dashfunc == true:
			#$Control/GetDash.visible = false


func _on_buy_pressed() -> void:
	var ItemHas = false
	if Globals.gold >= Globals.buyable_items[currItem]["Cost"]:
		for i in Globals.inventory:
			if Globals.inventory[i]["Name"] == Globals.buyable_items[currItem]["Name"]:
				Globals.inventory[i]["Count"] += 1
				ItemHas = true
		if ItemHas == false:
			var tempDic = Globals.buyable_items[currItem]
			tempDic["Count"] = 1
			Globals.inventory[Globals.inventory.size()] = tempDic
		Globals.gold -= Globals.buyable_items[currItem]["Cost"]
	print(Globals.inventory)


func _on_get_dash_pressed() -> void:
	GlobalVars.player_dashfunc = true
	$Control/GetDash.visible = false
	
