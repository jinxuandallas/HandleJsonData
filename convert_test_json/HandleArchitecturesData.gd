extends Node

var arc_arr:Array
var jun_arr:Array
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
		
	_handle_jun()
#	_handle_architectures_data()
#	print(arc_arr)

# 处理生成郡的数据
func _handle_jun():
	var id=0
	for arc in arc_arr:
		if _is_new_jun(arc["Jun"]):
			var junzhi_id=-1
			if bool(arc["JunZhi"])==true:
				junzhi_id=int(arc["Id"])
			jun_arr.append({"Id":id,"Name":arc["Jun"],"JunZhi":junzhi_id})
			id+=1
			continue
		if bool(arc["JunZhi"])==true:
			_find_jun(arc)
			
	var file=File.new()
	file.open("res://convert_test_json/new_data/Jun.json",File.WRITE)
	file.store_string(JSON.print(jun_arr,"\t"))
	file.close()
#	print(jun_arr)


# 设置郡治	
func _find_jun(arc):
	for jun in jun_arr:
		if jun["Name"]==arc["Jun"]:
			jun["JunZhi"]=int(arc["Id"])
			break

# 判断郡是否是新郡	
func _is_new_jun(jun_name):
	if jun_name=="":
		return false
	
	if jun_arr.size()==0:
		return true
		
	for jun in jun_arr:
		if jun["Name"]==jun_name:
			return false
	
	return true
	
			
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
