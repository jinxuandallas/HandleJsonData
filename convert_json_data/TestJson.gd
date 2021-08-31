extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_read_test_json()


func _read_test_json():
	var file=File.new()
	if not file.file_exists("res://Json/test/280LWSG.json"):
		print("文件不存在")
		
		return
		
	file.open("res://Json/test/280LWSG.json",File.READ)
	var json_data=parse_json(file.get_as_text())

	if json_data.size()>0:
		print(json_data.size())
#		for i in json_data:
			
	var sub_json=json_data["Persons"]
	print(sub_json.size())
	
	var go_json=sub_json["GameObjects"]
#	for i in sub_json["GameObjects"]:
#		print(i)
	print(go_json.size())
	
	for i in go_json:
		print("Id:%s,%s%s"%[i["ID"], i["SurName"],i["GivenName"]])
		
		
	file.close()
#		print(json_data["AiBattlingArchitectureStrings"])
