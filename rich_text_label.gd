extends RichTextLabel


var time:int = 1000
var sum = 0
var target = 1
var oo = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = str(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sum = sum + delta
	
	if sum > target :
		target = 2 - sum
		print (str(time))
		time = time - 1
		self.text = str(time)
		sum = 0
