class_name UserPreferences extends Resource

@export_range(-80, 1, 0.5) var music_volume = -10.0
@export_range(-80, 1, 0.5) var fx_volume = 0.0


static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res
