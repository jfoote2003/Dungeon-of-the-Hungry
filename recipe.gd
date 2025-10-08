class_name Recipe extends Resource

@export var recipe_output : ItemDataConsumable
@export var recipe_list : Array[Array]


func compare(input_array : Array) -> ItemDataConsumable:
	if input_array == []:
		return null
	
	for i in self.recipe_list.size():
		if input_array == recipe_list[i]:
			return recipe_output
	
	return null
