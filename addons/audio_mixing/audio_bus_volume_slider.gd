extends Slider


export var bus_name: String = "Master"

export var audio_duration_after_drag_ended: float = 2.0
export(NodePath) var example_audio_path
onready var example_audio = get_node(example_audio_path)

var bus_index: int
var timer: SceneTreeTimer


func _ready():
    bus_index = AudioServer.get_bus_index(bus_name)
    
    var converted_val = pow(10, AudioServer.get_bus_volume_db(bus_index) / 20)
    self.value = converted_val
    
    # connect signals
    connect("value_changed", self, "_on_value_changed")
    connect("drag_ended", self, "_on_drag_ended")
    
    # create timer
    get_tree().create_timer(5.0)


func _on_value_changed(value: float):
    # disconnect currently running timer to not
    # stop the audio while moving the slider
    if timer:
        if timer.is_connected("timeout", self, "_on_timeout"):
            timer.disconnect("timeout", self, "_on_timeout")

    # set the volume in db or mute if min value was reached
    if value == self.min_value:
        AudioServer.set_bus_mute(bus_index, true)
    else:
        AudioServer.set_bus_mute(bus_index, false)
        AudioServer.set_bus_volume_db(bus_index, log(value) * 20)
    
    if not example_audio.playing:
        example_audio.play()

# create a timer after which the audio will stop playing
func _on_drag_ended(value_changed: bool):
    timer = get_tree().create_timer(audio_duration_after_drag_ended)
    timer.connect("timeout", self, "_on_timeout")

func _on_timeout():
    print("STOP")
    example_audio.stop()
