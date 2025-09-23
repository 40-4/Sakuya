extends SakuyaCommand

func execute() -> void:
	var ret_val : String = ""
	if check_arg_count(1) == true:
		for command in SakuyaRoot.command_list:
			if context[1] == command.alias:
				ret_val = command.description
				SakuyaRoot.out(ret_val)
				return
		command_error("Cannot find a command with alias %s" % context[1])
	elif check_arg_count(0) == true:
		ret_val = "Avaliable commands: "
		for command in SakuyaRoot.command_list:
			ret_val += command.alias + ", "
		ret_val = ret_val.trim_suffix(", ")
		SakuyaRoot.out(ret_val)
		return
	else:
		command_error("Invalid argument count")
