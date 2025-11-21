extends VBoxContainer

@export var language_option : OptionButton

var languages := {
	"English": "en",
	"Spanish": "es",
	"German": "ge",
	"French": "fr",
	"Korean": "ko",
	"Chinese": "ch",
	"Japanese": "ja"
}

func _ready() -> void:
	for lang_name in languages.keys():
		language_option.add_item(lang_name)
	
	var current_locale := TranslationServer.get_locale()
	for i in range(language_option.item_count):
		var lang_name := language_option.get_item_text(i)
		if current_locale.begins_with(languages[lang_name]):
			language_option.select(i)
			break
	
	language_option.item_selected.connect(_on_language_slecected)

func _on_language_slecected(index : int):
	var lang_name := language_option.get_item_text(index)
	var locale = languages[lang_name]
	TranslationServer.set_locale(locale)
	print("locale set to: ", locale)
