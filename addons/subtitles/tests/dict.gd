extends Node


var queue = {}
var i = 0
var i_beginning = 0

var time_start = 0
var time_now = 0

func _ready():
    for x in range(0, 1000):
        queue[str(i)] = "example text"
        i += 1

    connect("pressed", self, "_on_button_pressed")


func _on_button_pressed():
    print("I'm doing something")

    for x in range(0, 5):
        time_start = OS.get_ticks_msec()
        
        for y in range(0, 1000000):
            var entry = queue[str(i_beginning)]
            queue[str(i)] = "example text"
            
            queue.erase(str(i_beginning))
            
            i_beginning += 1
            i += 1
        
        time_now = OS.get_ticks_msec()
        var time_elapsed = time_now - time_start
        print(str(x) + ": " + str(time_elapsed) + " ms")
