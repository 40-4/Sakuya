extends Logger
## Script used for intercepting print messages and pushed errors

func _log_message(message: String, error: bool) -> void:
	if SakuyaRoot.send_prints == true and error == false:
		SakuyaRoot.out(message.trim_suffix("\n"))

func _log_error(function: String, file: String, line: int, code: String, rationale: String, editor_notify: bool, error_type: int, script_backtraces: Array[ScriptBacktrace]) -> void:
	if SakuyaRoot.send_errors == true:
		var message : String = \
		"[color={sev}]Error type: {type}\n\tError in function \"{func}\" ({file}:{line})\n"
		if code != "":
			message += "\tCode: {code}\n"
		if rationale != "":
			message += "\tRationale: {rationale}\n"
		message += "\t{backtrace}[/color]"
		
		var e_type : String
		var e_sev : String = "firebrick"
		
		match error_type:
			ERROR_TYPE_ERROR:
				e_type = "ERROR"
			ERROR_TYPE_SCRIPT:
				e_type = "SCRIPT"
			ERROR_TYPE_SHADER:
				e_type = "SHADER"
			ERROR_TYPE_WARNING:
				e_type = "WARNING"
				e_sev = "goldenrod"
		
		var backtrace_msg : String = ""
		for i in script_backtraces:
				backtrace_msg += i.format().replace("    ", "\t\t") + "\n"
		
		backtrace_msg = backtrace_msg.trim_suffix("\n")
		
		message = message.format({
			"sev" : e_sev,
			"type" : e_type,
			"func" : function,
			"code" : code,
			"rationale" : rationale,
			"file" : file,
			"line" : line,
			"backtrace" : backtrace_msg
		})
		
		SakuyaRoot.out(message)
