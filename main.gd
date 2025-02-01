extends Node2D

signal screen_size_changed(newSize: Rect2, oldSize: Rect2)

var origin = Vector2(0, 0)
var screenRect: Rect2
var screenRectPrev = Rect2(0, 0, 0, 0)

func _ready():
	# setup backround size
	SetupScreenRect()	
	# emit initial increase
	EmitScreenSizeChanged()
	# connect to window size changes
	get_window().size_changed.connect(OnWindowSizeChanged)

func OnWindowSizeChanged():
	if SetupScreenRect():
		EmitScreenSizeChanged()

func SetupScreenRect() -> bool:
	var screenSize = get_window().get("size")
	if screenSize.x != screenRectPrev.size.x or screenSize.y != screenRectPrev.size.y:
		screenRect = Rect2(origin, screenSize)
		return true
	else:
		return false
		
func EmitScreenSizeChanged():
	screen_size_changed.emit(screenRect, screenRectPrev)
	screenRectPrev.size.x = screenRect.size.x
	screenRectPrev.size.y = screenRect.size.y
