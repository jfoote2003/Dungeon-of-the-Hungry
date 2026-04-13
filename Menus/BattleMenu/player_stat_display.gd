class_name PlayerStatDisplay extends HBoxContainer

func set_default(member : Combatant):
	%CombatantName.text = member.combatant_name
	set_current_health(member.get_health())
	set_max_health(member.get_max_health())
	set_current_hunger(member.get_hunger())
	set_max_hunger(member.get_max_hunger())
	set_time(member.atb_gauge)

func set_current_health(current_health : int):
	%CurrentHealth.text = str(current_health)
	%HealthBar.value = current_health

func set_max_health(max_health : int):
	%MaxHealth.text = str(max_health)
	%HealthBar.max_value = max_health

func set_current_hunger(current_hunger : int):
	%CurrentHunger.test = str(current_hunger)
	%HungerBar.value = current_hunger

func set_max_hunger(max_hunger : int):
	%MaxHunger.text = str(max_hunger)
	%HungerBar.max_value = max_hunger

func set_time(time : float):
	if time >= %ATBGauge.max_value:
		%ATBGauge.value = 100.0
	elif time <= %ATBGauge.min_value:
		%ATBGauge.value = 0.0
	else:
		%ATBGauge.value = time
