extends Selector
class_name RandomSelector


#Called when the task is entered
func task_enter(blackboard):
	self.blackboard = blackboard
	current_index = 0
	children_indexes = range(get_child_count())
	children_indexes.shuffle()
	get_child(children_indexes[current_index]).task_enter(blackboard)
	
