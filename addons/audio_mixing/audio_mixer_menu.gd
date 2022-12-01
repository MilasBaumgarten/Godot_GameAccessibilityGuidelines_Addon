extends Control


export(NodePath) var master_volume_slider_path
onready var master_volume = get_node(master_volume_slider_path)
export(NodePath) var music_volume_slider_path
onready var music_volume = get_node(music_volume_slider_path)

var master_volume_bus_index: int
var music_volume_bus_index: int


func _ready():
    master_volume_bus_index = AudioServer.get_bus_index("Master")
    music_volume_bus_index  = AudioServer.get_bus_index("Music")
    
    var converted_val_master = pow(10, AudioServer.get_bus_volume_db(master_volume_bus_index) / 20)
    var converted_val_music = pow(10, AudioServer.get_bus_volume_db(music_volume_bus_index) / 20)
    
    master_volume.value = converted_val_master
    music_volume.value  = converted_val_music


func _on_MasterVolumeSlider_value_changed(value):
    AudioServer.set_bus_volume_db(master_volume_bus_index, log(value) * 20)


func _on_MusicVolumeSlider_value_changed(value):
    AudioServer.set_bus_volume_db(music_volume_bus_index, log(value) * 20)

# TODO:
# - Skript wahrscheinlich lieber zu den Slidern bewegen und einzelner machen
# - kurz Beispiel Audio abspielen, während Slider bewegt wird
#   - nach Slider loslassen läuft kurzer Timer ab, nach dem die Audio wieder ausgeht
# - Bei Slider min muten
