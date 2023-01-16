extends Node


const subtitle_asset = preload("res://addons/subtitles/scenes/subtitle_asset.tscn")
var subtitle_instance: Node
var subtitle_label: Label

var queue = PoolStringArray()

var timer: SceneTreeTimer
var is_idle: bool = true


func _ready():
    # instantiate the subtitle asset
    subtitle_instance = subtitle_asset.instance()
    print(typeof(subtitle_instance))
    self.add_child(subtitle_instance)
    subtitle_label = subtitle_instance.get_node("PanelContainer/Label")
    
    # hide subtitles
    subtitle_instance.hide()


func _process(delta):
    # process the queue if entries exist
    if queue.size() > 0 && is_idle:
        subtitle_instance.show()
        
        var element = _pop_from_queue()
        print(element +  "\tleft: " + str(queue.size()))
        subtitle_label.text = element
        
        # "stop" the currently running timer, to continue playing audio while
        # changing the volume
        if timer:
            if timer.is_connected("timeout", self, "_on_timeout"):
                timer.disconnect("timeout", self, "_on_timeout")
        timer = get_tree().create_timer(3)
        timer.connect("timeout", self, "_on_timeout")
        is_idle = false


func add_to_queue(value: String):
    queue.push_back(value)


func _pop_from_queue() -> String:
    if queue.size() > 0:
        var element = queue[0]
        queue.remove(0)
        return element
    else:
        return ""


func _on_timeout():
    is_idle = true
    
    # hide subtitles
    subtitle_instance.hide()
