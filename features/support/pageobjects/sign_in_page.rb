require_relative "./common_page_object.rb"

class SignInPage < CommonPageObject

		def register()
			$driver.element(:id => "auth-create-account-link")
		end


	def navigate_to()
		home_page = $page_loader.load("Home Page")
		home_page.navigate_to();
		home_page.sign_in_link.click
	end
end