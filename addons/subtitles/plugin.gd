tool
extends EditorPlugin


var editor_interface = null


func _init():
    print("Initialising Subtitles plugin")

func _notification(p_notification: int):
    match p_notification:
        NOTIFICATION_PREDELETE:
            print("Destroying Subtitles plugin")


func _get_plugin_name() -> String:
    return "Subtitles"


func _enter_tree() -> void:
    editor_interface = get_editor_interface()
    add_autoload_singleton("Subtitles", "res://addons/subtitles/subtitles.gd")


func _exit_tree() -> void:
    remove_autoload_singleton("Subtitles")
