module ApplicationHelper
	def user_name(user, possessive=false)
		if signed_in? and current_user == user
			if possessive
				"Your"
			else
				"You"
			end
		else
			"#{user.name}'s"
		end
	end
end
