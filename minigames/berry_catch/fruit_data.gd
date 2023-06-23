extends RefCounted
class_name FruitData

@export var fruit_index := 0
@export var chance_weight := 100
var chance_weight_tier
@export var fruit_name := "Fruit"
@export var picture := preload("res://assets/textures/minigames/apple.png")
@export var fruit_size := 10.0

func _init( id:int, name_fruit:String, size, pic:=picture, chance:=100):
	
	fruit_index = id
	fruit_name = name_fruit
	chance_weight = chance
	picture = pic
	fruit_size = size
	
	pass
