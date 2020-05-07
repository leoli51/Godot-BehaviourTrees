extends Sequence
class_name RandomSequence

#The task process function is handled by the sequence class
func task_enter(blackboard):	
	self.blackboard = blackboard
	children_indexes = range(get_child_count())
	children_indexes.shuffle()
	current_index = 0
	get_child(children_indexes[current_index]).task_enter(blackboard)
