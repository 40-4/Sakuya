extends SakuyaCommand

func execute(command : PackedStringArray) -> void:
	if command.size() > 2:
		SakuyaCLI.log_message("Too many arguments! Expected 0, got %s" % (command.size() - 1))
		return
	elif command.size() == 2:
		if SakuyaCLI.alias_dict.has(command[1]):
			SakuyaCLI.log_message("%s" % SakuyaCLI.alias_dict[command[1]].description)
		else:
			SakuyaCLI.log_message("Wrong argument! There is no such command as %s" % command[1])
			return
	else:
		var result = "Avaliable commands:\n"
		result += ", ".join(PackedStringArray(SakuyaCLI.alias_dict.keys()))
		result += "\nTo learn more about specific command use \"help [command]\""
		SakuyaCLI.log_message(result)
		return
