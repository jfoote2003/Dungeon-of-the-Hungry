extends HBoxContainer

func update_stat_block(party_list : Array):
	update_character1_block(party_list[0])
	update_character2_block(party_list[1])
	update_character3_block(party_list[2])
	update_character4_block(party_list[3])

func update_character1_block(party_member1 : PartyMember):
	%Character1NameS.text = party_member1.name
	%Character1Strength.text = party_member1.rpg_class.strength
	%Character1Agility.text = party_member1.rpg_class.agility
	%Character1Endurance.text = party_member1.rpg_class.endurance
	%Character1Inteligence.text = party_member1.rpg_class.intelligence
	%Character1Devotion.text = party_member1.rpg_class.devotion
	%Character1Cooking.text = party_member1.rpg_class.cooking
	%Character1Luck.text = party_member1.rpg_class.luck

func update_character2_block(party_member2 : PartyMember):
	%Character2NameS.text = party_member2.name
	%Character2Strength.text = party_member2.rpg_class.strength
	%Character2Agility.text = party_member2.rpg_class.agility
	%Character2Endurance.text = party_member2.rpg_class.endurance
	%Character2Inteligence.text = party_member2.rpg_class.intelligence
	%Character2Devotion.text = party_member2.rpg_class.devotion
	%Character2Cooking.text = party_member2.rpg_class.cooking
	%Character2Luck.text = party_member2.rpg_class.luck

func update_character3_block(party_member3 : PartyMember):
	%Character3NameS.text = party_member3.name
	%Character3Strength.text = party_member3.rpg_class.strength
	%Character3Agility.text = party_member3.rpg_class.agility
	%Character3Endurance.text = party_member3.rpg_class.endurance
	%Character3Inteligence.text = party_member3.rpg_class.intelligence
	%Character3Devotion.text = party_member3.rpg_class.devotion
	%Character3Cooking.text = party_member3.rpg_class.cooking
	%Character3Luck.text = party_member3.rpg_class.luck

func update_character4_block(party_member1 : PartyMember):
	%Character4NameS.text = party_member1.name
	%Character4Strength.text = party_member1.rpg_class.strength
	%Character4Agility.text = party_member1.rpg_class.agility
	%Character4Endurance.text = party_member1.rpg_class.endurance
	%Character4Inteligence.text = party_member1.rpg_class.intelligence
	%Character4Devotion.text = party_member1.rpg_class.devotion
	%Character4Cooking.text = party_member1.rpg_class.cooking
	%Character4Luck.text = party_member1.rpg_class.luck
