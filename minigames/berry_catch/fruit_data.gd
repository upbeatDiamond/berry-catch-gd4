extends Sprite2D
class_name FruitData

@export var fruit_index := 0
@export var chance_weight := 100
@export var fruit_name := "Fruit"

func _init( id:int, name_fruit:String, chance:=100 ):
	
	fruit_index = id
	fruit_name = name_fruit
	chance_weight = chance
	
	pass
