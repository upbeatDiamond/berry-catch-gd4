extends Node2D

var fruit_caught := 0

@onready var ground_area = $GroundArea
@onready var ground_shape = $GroundArea/GroundShape
@onready var background = $Background/BackgroundPlane
@onready var text_display = $RichTextLabel
@onready var fruit_types : Array[FruitData] = [ FruitData.new(0, "Apple", 128, preload("res://assets/textures/berries/berry_peachy.png")),
												FruitData.new(1, "Wastum Berry", 64, preload("res://assets/textures/berries/berry_wastum.png")) ]

@export var fruit_template := preload("res://minigames/berry_catch/fruit.tscn")

var is_prepared := false

var falling_fruit : int = 3

func fruit_prep( varieties:=fruit_types ):
	if varieties.size() > 0:
		fruit_types = varieties
	
	var i:int = 1
	fruit_types[0].chance_weight_tier = fruit_types[0].chance_weight
	while i < fruit_types.size():
		fruit_types[i].chance_weight_tier = fruit_types[i].chance_weight + fruit_types[i-1].chance_weight_tier
		i += 1
	
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	fruit_prep()
	start_game_prep()
	pass


func start_game_prep():
	ground_shape.shape.size = Vector2(background.size.x*2, background.size.y)
	ground_area.position = Vector2(background.size.x/2, background.size.y/2)
	
	print("Ground at ", ground_area.position, " with shape ", ground_shape.shape.size)
	
	
	var new_fruit
	var i = 0
	print( fruit_template.can_instantiate() )
	while i < falling_fruit:
		new_fruit = fruit_template.instantiate() as FruitWrapper
		add_child( new_fruit )
		new_fruit.position = Vector2(background.size.x*2, randi_range(FruitArea.PRESET_Y_RESET, 2*FruitArea.PRESET_Y_RESET) )
		new_fruit.area.fruit_caught.connect(_on_fruit_area_fruit_caught)
		new_fruit.area.fruit_reset.connect(change_fruit)
		i += 1
	
	is_prepared = true
	pass


func change_fruit( fruit_area:FruitArea ):
	var random_weight = randi_range( 0, fruit_types[ -1 ].chance_weight_tier )
	var i = 0
	while fruit_types[i].chance_weight_tier < random_weight:
		i += 1
	
	print("Fruit type changed to ", i, " for weight ", random_weight)
	fruit_area.set_new_fruit( fruit_types[i] )
	
	pass


func _on_fruit_area_fruit_caught( _fruit_type ):
	
	fruit_caught += 1;
	text_display.text = str("fruit: ", fruit_caught)
	
	pass
