extends Node2D
@onready var canvas_layer = $"."
const inverseProbability = 500
var origin = Vector2(0, 0)
var screenRect
var screenRectMax = Rect2(0, 0, 0, 0)
var random
var magicNumber
var oldStars: PackedVector2Array = PackedVector2Array()

func _ready():	
	# setup star randomizer
	random = RandomNumberGenerator.new()
	random.randomize()
	magicNumber = random.randi() % inverseProbability

func _draw():
	if(screenRect == null):
		return
	DrawBlackBackground()
	DrawStars()
	UpdateMaxScreenRect()

func _on_screen_size_changed(newSize: Rect2, _oldSize):
	screenRect = newSize
	canvas_layer.queue_redraw()

func DrawBlackBackground():
	canvas_layer.draw_rect(screenRect, Color.BLACK)

func DrawStars():
	DrawOldStars()
	for x in screenRect.size.x:
		for y in screenRect.size.y:
			if x > screenRectMax.size.x or y > screenRectMax.size.y:
				DrawRandomStar(x, y)

func DrawOldStars():
	for coord in oldStars:
		DrawStar(coord)

func DrawRandomStar(x: int, y: int):
	if random.randi() % inverseProbability == magicNumber:
		var coord = Vector2(x, y)
		DrawStar(coord)
		oldStars.append(coord)

func DrawStar(coord: Vector2):
	canvas_layer.draw_circle(coord, 1, Color.WHITE)
	
func UpdateMaxScreenRect():
	if(screenRect.size.x > screenRectMax.size.x):
		screenRectMax.size.x = screenRect.size.x
	if(screenRect.size.y > screenRectMax.size.y):
		screenRectMax.size.y = screenRect.size.y
