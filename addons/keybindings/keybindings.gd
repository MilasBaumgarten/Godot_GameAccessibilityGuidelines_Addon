tool
extends EditorPlugin

var editor_interface = null


func _init():
    print("Initialising Keybinding plugin")

func _notification(p_notification: int):
    match p_notification:
        NOTIFICATION_PREDELETE:
            print("Destroying Keybinding plugin")


func _get_plugin_name() -> String:
    return "Keybinding"


func _enter_tree() -> void:
    editor_interface = get_editor_interface()
    add_autoload_singleton("KeyPersistence", "res://addons/keybindings/key_persistence.gd")


func _exit_tree() -> void:
    remove_autoload_singleton("KeyPersistence")
