--- @sync entry
return {
	entry = function(_, job)
		local current = cx.active.current
		local new = (current.cursor + job.args[1]) % #current.files
		ya.mgr_emit("arrow", { new - current.cursor })
	end,
}