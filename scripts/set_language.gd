extends Button

export(String) var language_short_name


func _ready():
    connect("pressed", self, "_on_pressed")


func _on_pressed():
    TranslationServer.set_locale(language_short_name)
