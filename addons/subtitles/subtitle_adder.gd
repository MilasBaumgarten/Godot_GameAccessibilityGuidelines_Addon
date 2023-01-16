extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
    connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
    Subtitles.add_to_queue(text)
