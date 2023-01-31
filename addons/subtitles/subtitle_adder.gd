extends Button

export (String) var content_identifier_string
export (float) var duration = 2.0


func _ready():
    connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
    Subtitles.add_to_queue(tr(content_identifier_string), duration)
