extends Node


var queue = PoolStringArray()
var queue_size = 100
var i = 0

var time_start = 0
var time_now = 0


func _ready():
    for x in range(0, queue_size):
        queue.append("example text")
    connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
    print("I'm doing something")

    for x in range(0, 5):
        time_start = OS.get_ticks_msec()
        
        for y in range(0, 1000000):
            var entry = queue[i]
            queue[i] = "example text"
            
            if i < queue_size - 1:
                i += 1
            else:
                i = 0
        
        time_now = OS.get_ticks_msec()
        var time_elapsed = time_now - time_start
        print(str(x) + ": " + str(time_elapsed) + " ms")
