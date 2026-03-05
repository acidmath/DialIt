@tool # Allows the function to run in the editor
extends Path2D

func generate_circle_path(radius: float, points: int):
	curve = Curve2D.new()
	curve.clear_points()
	
	# Calculate points for a full circle
	for i in range(points + 1):
		# Calculate the angle for this point (TAU is 2 * PI)
		var angle = (i / float(points)) * TAU
		
		# Calculate the x and y coordinates
		var x = radius * cos(angle)
		var y = radius * sin(angle)
		
		# Add the point to the curve
		curve.add_point(Vector2(x, y))
	# Close the curve to form a complete loop in the editor
	# Note: the close curve button in editor does something similar visually
	pass # The loop range already connects the start and end point

# Example usage in _ready or as a callable function in the editor
func _ready():
	generate_circle_path(100.0, 60) # Generate a circle with radius 100 and 60 points
	
	var line_2d = get_node("Line2D") # Get the Line2D node
	if line_2d:
		# Set Line2D points to the baked points of the curve
		line_2d.points = curve.get_baked_points()
		line_2d.width = 5.0 # Set desired width
		line_2d.default_color = Color.WHITE # Set desired color
