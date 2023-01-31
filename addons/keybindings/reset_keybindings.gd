extends Button


func _ready():
    connect("pressed", self, "_buttond_up")


func _buttond_up():
    print("resetting")
    KeyPersistence.reset_keymap()
    
    # find all nodes of a specific type
    var res = []
    _find_by_class(owner, "Button", res)
    # call method "display_current_key" on all found nodes if it exists
    for node in res:
        if node.has_method("display_current_key"):
            node.display_current_key()


func _find_by_class(node: Node, className : String, result : Array) -> void:
    if node.is_class(className) :
        result.push_back(node)
    for child in node.get_children():
        _find_by_class(child, className, result)
