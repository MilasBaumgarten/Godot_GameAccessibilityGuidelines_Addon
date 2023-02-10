extends Slider


export(String, FILE, "*tres") var default_font_path
var default_font: DynamicFont
var default_size: int


func _ready():
    connect("value_changed", self, "_on_value_changed")
#    connect("drag_ended", self, "_on_drag_ended")
    
    # assert scene exists
    assert(ResourceLoader.exists(default_font_path), "No default font exists at: " + default_font_path + "!" +
    "\nObject: " + self.name + 
    "\nScene: " + owner.get_name())
    
    default_font = load(default_font_path)
    default_size = default_font.size


func _on_value_changed(value: float):
    default_font.size = int(default_size * value)

func _on_drag_ended(value_changed: bool):
    if value_changed:
        default_font.size = int(default_size * self.value)
