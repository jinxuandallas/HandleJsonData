extends Node

var arc_arr:Array
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file=File.new()
	if file.file_exists("res://convert_test_json/new_data/Architectures.json"):
		_read_architectures_data()
	else:
		_merge_architectures_data()
		
	_handle_architectures_data()
#	print(arc_arr)
func _handle_architectures_data():
	var add_dataname=["Agriculture","Commerce","Endurance","Food","Fund","Population","PersonsString"]
	var file=File.new()
	file.open("res://Json/test/280LWSG.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	print(json_data["Architectures"]["GameObjects"].size())
	for used_arc in arc_arr:
		var found=false
		for all_arc in json_data["Architectures"]["GameObjects"]:
			if used_arc["Name"]==all_arc["Name"]:
				found=true
				for key in add_dataname:
					used_arc[key]=all_arc[key]
				used_arc["Support"]=50
				used_arc["Food"]=used_arc["Food"]/100
				used_arc["Fund"]=used_arc["Fund"]/100
				break
		if !found:
			print("%s not found"%used_arc["Name"])
#		print(used_arc)
		
	file.close()
	
	file=File.new()
	file.open("res://convert_test_json/new_data/new_Architectures.json",File.WRITE)
	file.store_string(JSON.print(arc_arr,"\t"))
	file.close()
	
	
func _read_architectures_data():
	var file=File.new()
	file.open("res://convert_test_json/new_data/Architectures.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	arc_arr=json_data
	file.close()
	
	
func _merge_architectures_data():
	# 读取数据
	var file=File.new()
	file.open("res://convert_test_json/old_data/Architectures.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	
	# 整理数据
	var i=0
	for arc in json_data:
		var same_arc=false
		for a in arc_arr:
			if arc["Name"]==a["Name"]:
				same_arc=true
#				print(a["MapPosition"] is Array)
				a["MapPosition"].append_array(arc["MapPosition"])
#				a["MapPosition"]=(a["MapPosition"]).append((arc["MapPosition"]))
				break
		if !same_arc:
			arc["Id"]=i
			arc_arr.append(arc)
			i=i+1
	file.close()
	
	
	# 写入数据
	file=File.new()
	file.open("res://convert_test_json/new_data/Architectures.json",File.WRITE)
	file.store_string(JSON.print(arc_arr,"\t"))
	file.close()
#	print(arc_arr)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
