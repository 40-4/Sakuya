extends SakuyaCommand
# This command is here to show you how to create your own commands, and explain some of the design choices.
# I'll try to explain what's going on, step by step.

# I want my "help" command to have two use cases:
# if you pass it without any arguments it will list all avaliable commands
# and you can pass the command alias, to see its description

# The command evaluation process is quite simple, the SakuyaRoot calls the _run() command, 
# which checks if the command have proper number of arguments through check_arg_count() function. 
# If that check passes, it calls the execute() function.

# OVERRIDING check_arg_count() COMMAND:
# Doing so will allow the command to accept both one and zero arguments.

func check_arg_count() -> bool:
	if context.size() == 1 or context.size() == 2:
		return true
	else:
		return false

# Now that command accepts both argument counts, we can differenciate the use in the execute() function.

# OVERRIDING execute() COMMAND:
func execute() -> void:
	var ret_val : String = ""
	match context.size():
		2:
			for command in SakuyaRoot.command_list:
				if context[1] == command.alias:
					ret_val = command.description
					SakuyaRoot.out(ret_val)
					return
			command_error("Cannot find a command with alias %s" % context[1])
		1:
			ret_val = "Avaliable commands: "
			for command in SakuyaRoot.command_list:
				ret_val += command.alias + ", "
			ret_val = ret_val.trim_suffix(", ")
			SakuyaRoot.out(ret_val)
			return

# In this implementation I differenciated the use via match statement, 
# but how you should do it depends heavily of what you want your command to do.
# If you have any issues or questions, please make a Github issue here: https://github.com/40-4/Sakuya/issues
