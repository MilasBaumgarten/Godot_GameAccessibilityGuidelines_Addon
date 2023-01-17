# This is an autoload (singleton) which will save
# the key maps in a simple way through a dictionary.
extends Node

const keymaps_path = "user://keymaps.dat"
var keymaps: Dictionary
var keymaps_backup: Dictionary


func _ready() -> void:
    # First we create the keymap dictionary on startup with all
    # the keymap actions we have.
    for action in InputMap.get_actions():
        if InputMap.get_action_list(action).size() > 0:
            keymaps[action] = InputMap.get_action_list(action)[0]
        else:
            keymaps[action] = ""
    
    keymaps_backup = keymaps.duplicate()
    load_keymap()


func load_keymap() -> void:
    var file := File.new()
    if not file.file_exists(keymaps_path):
        save_keymap() # There is no save file yet, so let's create one.
        return
    
    #warning-ignore:return_value_discarded
    file.open(keymaps_path, File.READ)
    var temp_keymap: Dictionary = file.get_var(true)
    file.close()
    
    _set_actions(temp_keymap)


func save_keymap() -> void:
    # For saving the keymap, we just save the entire dictionary as a var.
    var file := File.new()
    #warning-ignore:return_value_discarded
    file.open(keymaps_path, File.WRITE)
    file.store_var(keymaps, true)
    file.close()


func reset_keymap() -> void:
    _set_actions(keymaps_backup)
    save_keymap()


func _set_actions(new_values: Dictionary):
    for action in keymaps.keys():
        if new_values.has(action):
            # Whilst setting the keymap dictionary, we also set the
            # correct InputMap event
            keymaps[action] = new_values[action]
            InputMap.action_erase_events(action)
            # check that the keymap value is not a string (aka: "") (should be an object)
            if typeof(keymaps[action]) != 4:
                InputMap.action_add_event(action, keymaps[action])
#                print(str(action) + " - " + keymaps[action].as_text())
            else:
                print(str(action) + " is unbound.")
        else:
            print(str(action) + " is missing.")
