extends Control

signal stat_changed(stat_array : Array)

#stat output
var strength : int = 0
var agility : int = 0
var endurance : int = 0
var intelligence : int = 0
var devotion : int = 0
var luck : int = 0
var cooking : int = 0

var player_strength : int = 0
var player_agility : int = 0
var player_endurance : int = 0
var player_intelligence : int = 0
var player_devotion : int = 0
var player_luck : int = 0
var player_cooking : int = 0

var stat_points : int = 0
var stats_updated : bool = false

func _ready():
	%StrengthIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%AgilityIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%EnduranceIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%IntelligenceIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%DevotionIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%LuckIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	%CookingIncrease.texture_normal = preload("uid://cf5elr0cl5lgl")
	
	%StrengthDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%AgilityDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%EnduranceDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%IntelligenceDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%DevotionDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%LuckDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	%CookingDecrease.texture_normal = preload("uid://dlulqb3cjdnnp")
	

func _process(_delta: float) -> void:
	if stats_updated == false:
		update_stat_display()
		stats_updated = true

func _on_strength_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		strength += 1
		%StrengthDisplay.text = str(strength)
	update_stat_points()

func _on_strength_decrease_pressed() -> void:
	strength -= 1
	stat_points += 1
	if strength < 0:
		strength = 0
		stat_points -= 1
	%StrengthDisplay.text = str(strength)
	update_stat_points()

func _on_agility_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		agility += 1
		%AgilityDisplay.text = str(agility)
	update_stat_points()

func _on_agility_decrease_pressed() -> void:
	agility -= 1
	stat_points += 1
	if agility < 0:
		agility = 0
		stat_points -= 1
	%AgilityDisplay.text = str(agility)
	update_stat_points()

func _on_endurance_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		endurance += 1
		%EnduranceDisplay.text = str(endurance)
	update_stat_points()

func _on_endurance_decrease_pressed() -> void:
	endurance -= 1
	stat_points += 1
	if endurance < 0:
		endurance = 0
		stat_points -= 1
	%EnduranceDisplay.text = str(endurance)
	update_stat_points()

func _on_intelligence_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		intelligence += 1
		%IntelligenceDisplay.text = str(intelligence)
	update_stat_points()

func _on_intelligence_decrease_pressed() -> void:
	intelligence -= 1
	stat_points += 1
	if intelligence < 0:
		intelligence = 0
		stat_points -= 1
	%IntelligenceDisplay.text = str(intelligence)
	update_stat_points()

func _on_devotion_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		devotion += 1
		%DevotionDisplay.text = str(devotion)
	update_stat_points()

func _on_devotion_decrease_pressed() -> void:
	devotion -= 1
	stat_points += 1
	if devotion < 0:
		devotion = 0
		stat_points -= 1
	%DevotionDisplay.text = str(devotion)
	update_stat_points()

func _on_luck_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		luck += 1
		%LuckDisplay.text = str(luck)
	update_stat_points()

func _on_luck_decrease_pressed() -> void:
	luck -= 1
	stat_points += 1
	if luck < 0:
		luck = 0
		stat_points -= 1
	%LuckDisplay.text = str(luck)
	update_stat_points()

func _on_cooking_increase_pressed() -> void:
	if stat_points <= 0:
		#cant increase stats
		stat_points = 0
	else:
		stat_points -= 1
		cooking += 1
		%CookingDisplay.text = str(cooking)
	update_stat_points()

func _on_cooking_decrease_pressed() -> void:
	cooking -= 1
	stat_points += 1
	if cooking < 0:
		cooking = 0
		stat_points -= 1
	%CookingDisplay.text = str(cooking)
	update_stat_points()

func _on_submit_button_pressed() -> void:
	var stat_array : Array = [strength, agility, endurance, intelligence, devotion, luck, cooking]
	
	update_player_stat(stat_array)
	update_stat_display()
	
	stat_changed.emit(stat_array)
	reset_stat_array()

func update_stat_points():
	%LevelUpPointDisplay.text = str(stat_points)

func update_stat_display():
	%StrengthScore.text = str(player_strength)
	%AgilityScore.text = str(player_agility)
	%EnduranceScore.text = str(player_endurance)
	%IntelligenceScore.text = str(player_intelligence)
	%DevotionScore.text = str(player_devotion)
	%LuckScore.text = str(player_luck)
	%CookingScore.text = str(player_cooking)

func update_player_stat(stat_array : Array):
	player_strength += stat_array[0]
	player_agility += stat_array[1]
	player_endurance += stat_array[2]
	player_intelligence += stat_array[3]
	player_devotion += stat_array[4]
	player_luck += stat_array[5]
	player_cooking += stat_array[6]

func reset_stat_array():
	strength = 0
	agility = 0
	endurance = 0
	intelligence = 0
	devotion = 0
	luck = 0
	cooking = 0
	
	%StrengthDisplay.text = str(strength)
	%AgilityDisplay.text = str(agility)
	%EnduranceDisplay.text = str(endurance)
	%IntelligenceDisplay.text = str(intelligence)
	%DevotionDisplay.text = str(devotion)
	%LuckDisplay.text = str(luck)
	%CookingDisplay.text = str(cooking)
