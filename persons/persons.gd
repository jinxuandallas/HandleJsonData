extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file=File.new()
	if not file.file_exists("res://Json/test/280LWSG.json"):
		print("文件不存在")
		
		return
		
	file.open("res://Json/test/280LWSG.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	var person_arr:Array
	
	if json_data.size()>0:
#		print(json_data.size())
#		for i in json_data:
			
		var persons=json_data["Persons"]["GameObjects"]
		
		for i in persons:
			person_arr.append({"ID":int(i["ID"]),
					"SurName":i["SurName"],
					"GivenName":i["GivenName"],
					"CalledName":i["CalledName"],
					"BaseStrength":i["BaseStrength"],# 武力
					"BaseCommand":i["BaseCommand"],# 统率
					"BaseIntelligence":i["BaseIntelligence"],# 智力
					"BasePolitics":i["BasePolitics"],# 政治
					"BaseGlamour":i["BaseGlamour"],# 魅力
					"PictureIndex":i["PictureIndex"],
					"YearAvailable":i["YearAvailable"],
					"YearBorn":i["YearBorn"],
					"YearDead":i["YearDead"],
			})
#		print("Id:%s,%s%s"%[i["ID"], i["SurName"],i["GivenName"]])
		
	file.close()
	
	
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer/LabelId.text=str(person_arr[6]["ID"])
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer2/LabelYearBorn.text=str(person_arr[6]["YearBorn"])
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer3/LabelYearDead.text=str(person_arr[6]["YearDead"])
	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer/LabelName.text=person_arr[6]["SurName"]+person_arr[6]["GivenName"]
	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer2/LabelCalledName.text=str(person_arr[6]["CalledName"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer/LabelBaseStrength.text=str(person_arr[6]["BaseStrength"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer2/LabelBaseCommand.text=str(person_arr[6]["BaseCommand"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer3/LabelBaseIntelligence.text=str(person_arr[6]["BaseIntelligence"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer4/LabelBasePolitics.text=str(person_arr[6]["BasePolitics"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer5/LabelBaseGlamour.text=str(person_arr[6]["BaseGlamour"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
