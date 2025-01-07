extends Node2D
@onready var canvas_layer = $"."
var origin = Vector2(0, 0)
var screenRect
var random
var magicNumber
var maxWidth
var minWidth = 0
var maxHeight
var minHeight = 0
var oldStars: PackedVector2Array = PackedVector2Array()

func _ready():
	# setup backround size
	SetupScreenRect()
	
	# setup star randomizer
	random = RandomNumberGenerator.new()
	random.randomize()
	magicNumber = random.randi() % 1000
	
	# connect to window size changes
	get_window().size_changed.connect(OnWindowSizeChanged)

func _draw():
	DrawBlackBackground()
	DrawStars()

func OnWindowSizeChanged():
	if SetupScreenRect():
		canvas_layer.queue_redraw()

func SetupScreenRect() -> bool:
	var screenSize = get_window().get("size")	
	if maxWidth == null or maxHeight == null or screenSize.x > maxWidth or screenSize.y > maxHeight:
		screenRect = Rect2(origin, screenSize)
		maxWidth = screenSize.x
		maxHeight = screenSize.y
		return true
	else:
		return false

func DrawBlackBackground():
	canvas_layer.draw_rect(screenRect, Color.BLACK)

func DrawStars():
	DrawOldStars()
	for x in maxWidth:
		for y in maxHeight:
			if x > minWidth or y > minHeight:
				DrawRandomStar(x, y)
	minWidth = maxWidth
	minHeight = maxHeight

func DrawOldStars():
	for coord in oldStars:
		DrawStar(coord)

func DrawRandomStar(x: int, y: int):
	if random.randi() % 1000 == magicNumber:
		var coord = Vector2(x, y)
		DrawStar(coord)
		oldStars.append(coord)

func DrawStar(coord: Vector2):
	canvas_layer.draw_circle(coord, 1, Color.WHITE)
