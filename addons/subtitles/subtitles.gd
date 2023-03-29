extends Node

const subtitle_asset = preload("res://addons/subtitles/scenes/subtitle_asset.tscn")
var subtitle_instance: Node
var subtitle_label: Label

var queue_text = PoolStringArray()
var queue_duration = PoolRealArray()
var queue_size = 50
var queue_index_current = 0
var queue_index_last_element = 0

var is_idle: bool = true


func _ready():
    # instantiate the subtitle asset
    subtitle_instance = subtitle_asset.instance()
    self.add_child(subtitle_instance)
    subtitle_label = subtitle_instance.get_node("PanelContainer/Label")
    
    # hide subtitles
    subtitle_instance.hide()
    
    # set size of queues
    queue_text.resize(queue_size)
    queue_duration.resize(queue_size)


func _process(delta):
    # process the queue no entry is processed right now
    if is_idle == true && queue_text[queue_index_current] != "":
        subtitle_instance.show()
        
        var entry = _pop_from_queue()
        var duration = entry[1]
        subtitle_label.text = entry[0]
        
        is_idle = false
        yield(get_tree().create_timer(duration), "timeout")
        
        # hide subtitles
        subtitle_instance.hide()
        is_idle = true


# get's called from outside to add new text entries to to both queues
func add_to_queue(value: String, duration: float):
    queue_text[queue_index_last_element] = value
    queue_duration[queue_index_last_element] = duration
    
    if queue_index_last_element < queue_size - 1:
        queue_index_last_element += 1
    else:
        queue_index_last_element = 0
    
    # check if queue_index_last_element get's higher than queue_index_current
    # warn if this happens
    if queue_index_last_element == queue_index_current:
        print("WARNING: the subtitle queue encountered an overflow!\n" +
              "Please increase the queue size or implement a overflow queue.")
    

# get the current (oldest) entry from the text and duration queue
# afterwards increment the current index
# -> works kinda like FIFO but with a rotating index
# return the accessed current entries
func _pop_from_queue() -> Array:
    var element = queue_text[queue_index_current]
    var duration = queue_duration[queue_index_current]
    
    # remove accessed entry from queue
    queue_text[queue_index_current] = ""
    queue_duration[queue_index_current] = 0
    
    if queue_index_current < queue_size - 1:
        queue_index_current += 1
    else:
        queue_index_current = 0
    
    return [element, duration]
