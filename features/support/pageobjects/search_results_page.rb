require_relative "./common_page_object.rb"

class SearchResultsPage < CommonPageObject

	def send_message()
		$driver.button(:id, "submit")
	end

	def email_error()
		$driver.div(:text, "Please Enter Valid Email address")
	end
end