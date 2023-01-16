extends Node


const text_show_time = 3.0

const subtitle_asset = preload("res://addons/subtitles/scenes/subtitle_asset.tscn")
var subtitle_instance: Node
var subtitle_label: Label

var queue = PoolStringArray()

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
    if queue.size() > 0 and is_idle == true:
        subtitle_instance.show()
        
        var element = _pop_from_queue()
        print(element +  "\tleft: " + str(queue.size()))
        subtitle_label.text = element
        
        is_idle = false
        yield(get_tree().create_timer(text_show_time), "timeout")
        
        # hide subtitles
        subtitle_instance.hide()
        is_idle = true


func add_to_queue(value: String):
    queue.push_back(value)


func _pop_from_queue() -> String:
    if queue.size() > 0:
        var element = queue[0]
        queue.remove(0)
        return element
    else:
        return ""
