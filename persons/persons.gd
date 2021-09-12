extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _person_index
var person_arr:Array
#var person_biographies:Array
var person_biographies:Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	
	_read_person_data()
	_read_biographies()
	_person_index=0
	_show_person(_person_index)
#	$Panel/VBoxContainer/HBoxContainer/HBoxContainer/LabelId.text=str(person_arr[6]["ID"])
#	$Panel/VBoxContainer/HBoxContainer/HBoxContainer2/LabelYearBorn.text=str(person_arr[6]["YearBorn"])
#	$Panel/VBoxContainer/HBoxContainer/HBoxContainer3/LabelYearDead.text=str(person_arr[6]["YearDead"])
#	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer/LabelName.text=person_arr[6]["SurName"]+person_arr[6]["GivenName"]
#	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer2/LabelCalledName.text=str(person_arr[6]["CalledName"])
#	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer/LabelBaseStrength.text=str(person_arr[6]["BaseStrength"])
#	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer2/LabelBaseCommand.text=str(person_arr[6]["BaseCommand"])
#	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer3/LabelBaseIntelligence.text=str(person_arr[6]["BaseIntelligence"])
#	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer4/LabelBasePolitics.text=str(person_arr[6]["BasePolitics"])
#	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer5/LabelBaseGlamour.text=str(person_arr[6]["BaseGlamour"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	_save_persons()
	
	
func _read_person_data():
	var file=File.new()
	if not file.file_exists("res://Json/test/280LWSG.json"):
		print("文件不存在")
		
		return
	
	var person_keys=["ID","SurName","GivenName","CalledName","BaseStrength","BaseCommand","BaseIntelligence","BasePolitics",
	"BaseGlamour","PictureIndex","YearAvailable","YearBorn","YearDead","Sex","Ideal","PCharacter","AvailableLocation"
	]	
	file.open("res://Json/test/280LWSG.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	
	if json_data.size()>0:
#		print(json_data.size())
#		for i in json_data:
			
		var persons=json_data["Persons"]["GameObjects"]
		
		for i in persons:
			var person:Dictionary
			for key in person_keys:
				if i[key] is float:
					person[key]=int(i[key])
				else:
					person[key]=i[key]
			person_arr.append(person)
#			person_arr.append({"ID":int(i["ID"]),
#				"SurName":i["SurName"],
#				"GivenName":i["GivenName"],
#				"CalledName":i["CalledName"],
#				"BaseStrength":i["BaseStrength"],# 武力
#				"BaseCommand":i["BaseCommand"],# 统率
#				"BaseIntelligence":i["BaseIntelligence"],# 智力
#				"BasePolitics":i["BasePolitics"],# 政治
#				"BaseGlamour":i["BaseGlamour"],# 魅力
#				"PictureIndex":i["PictureIndex"],
#				"YearAvailable":i["YearAvailable"],
#				"YearBorn":i["YearBorn"],
#				"YearDead":i["YearDead"],
#			})
#		print("Id:%s,%s%s"%[i["ID"], i["SurName"],i["GivenName"]])
		
	file.close()
	
func _read_biographies():
	var file=File.new()
	if not file.file_exists("res://Json/test/Biographies.json"):
		print("文件不存在")
		
		return
		
	file.open("res://Json/test/Biographies.json",File.READ)
	var json_data=parse_json(file.get_as_text())
	
	if json_data.size()>0:
		
		
		for i in json_data:
			person_biographies[int(i["_Id"])]=i["Text"]
#			person_biographies.append({"ID":int(i["_Id"]),
#				"Text":i["Text"]
#			})
		
	file.close()

func _save_persons():
	var file=File.new()
	file.open("res://Json/test/Persons.json",File.WRITE)
	file.store_string(JSON.print(person_arr,"\t"))
	file.close()
	
func _show_person(person_index):
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer/LabelId.text=str(person_arr[person_index]["ID"])
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer2/LabelYearBorn.text=str(person_arr[person_index]["YearBorn"])
	$Panel/VBoxContainer/HBoxContainer/HBoxContainer3/LabelYearDead.text=str(person_arr[person_index]["YearDead"])
	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer/LabelName.text=person_arr[person_index]["SurName"]+person_arr[person_index]["GivenName"]
	$Panel/VBoxContainer/HBoxContainer2/HBoxContainer2/LabelCalledName.text=str(person_arr[person_index]["CalledName"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer/LabelBaseStrength.text=str(person_arr[person_index]["BaseStrength"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer2/LabelBaseCommand.text=str(person_arr[person_index]["BaseCommand"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer3/LabelBaseIntelligence.text=str(person_arr[person_index]["BaseIntelligence"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer4/LabelBasePolitics.text=str(person_arr[person_index]["BasePolitics"])
	$Panel/VBoxContainer/HBoxContainer3/HBoxContainer5/LabelBaseGlamour.text=str(person_arr[person_index]["BaseGlamour"])
	
	_show_portrait(person_index)
	$Panel/RichTextLabel.clear()
#	$Panel/RichTextLabel.append_bbcode(person_biographies[person_index]["Text"])
	$Panel/RichTextLabel.append_bbcode(person_biographies[person_arr[person_index]["ID"]])
	
	
func _on_Previous_pressed():
	_person_index=clamp(_person_index-1,0,person_arr.size()-1)
	_show_person(_person_index)

func _on_Next_pressed():
	_person_index=clamp(_person_index+1,0,person_arr.size()-1)
	_show_person(_person_index)


func _on_Confirm_pressed():
	_person_index=clamp(int($Panel/LineEdit.text),0,person_arr.size()-1)
	_show_person(_person_index)

func _show_portrait(person_index):
	var file=File.new()
	var portrait_path="res://image/PersonPortrait/%d.jpg"%person_index
	if not file.file_exists(portrait_path):
#		print("文件不存在")
		portrait_path="res://image/PersonPortrait/blank.jpg"
		
	$Panel/Sprite.texture=load(portrait_path)
