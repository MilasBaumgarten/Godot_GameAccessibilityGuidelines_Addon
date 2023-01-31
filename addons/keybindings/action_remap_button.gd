extends Button

export(String) var action = "ui_up"

func _ready():
    assert(InputMap.has_action(action))
    set_process_unhandled_key_input(false)
    display_current_key()


func _toggled(button_pressed):
    # wait one frame, this will stop ui_accept from instandly setting the keybinding
    yield(get_tree(), "idle_frame")
    
    set_process_unhandled_key_input(button_pressed)
    if button_pressed:
        text = "... Key"
    else:
        display_current_key()


func _unhandled_key_input(event):
    # Note that you can use the _input callback instead, especially if
    # you want to work with gamepads.
    
    # stop key change, when cancel action was pressed
    if not event.is_action("ui_cancel"):
        remap_action_to(event)
    pressed = false


func remap_action_to(event):
    # We first change the event in this game instance.
    InputMap.action_erase_events(action)
    InputMap.action_add_event(action, event)
    # And then save it to the keymaps file
    KeyPersistence.keymaps[action] = event
    KeyPersistence.save_keymap()


func display_current_key():
    if InputMap.get_action_list(action).size() > 0:
        var current_key = InputMap.get_action_list(action)[0].as_text()
        text = current_key + " Key"
    else:
        text = "KEYBINDINGS_UNBOUND"
