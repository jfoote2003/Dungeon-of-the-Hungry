class_name Queue extends Resource

var queue : Array = []

func enqueue(item):
	self.queue.append(item)

func dequeue() -> bool:
	if is_empty():
		return false
	else:
		self.queue.pop_at(0)
		return true

func is_empty() -> bool:
	return self.queue.size() == 0

func peek() -> int:
	if is_empty():
		return 0
	else:
		return self.queue.size()
