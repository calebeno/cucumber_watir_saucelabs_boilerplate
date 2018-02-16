require_relative "./common_page_object.rb"

class CreateAccountPage < CommonPageObject

    def name()
      $driver.element(:xpath => "//input[@name='customerName']")
    end

  def email()
    $driver.element(:xpath => "//input[@name='email']")
  end

  def password()
    $driver.element(:xpath => "//input[@name='password']")
  end

  def confirm_password()
    $driver.element(:xpath => "//input[@name='passwordCheck']")
  end

  def missing_name_error()
    $driver.element(:id => "auth-customerName-missing-alert")
  end

  def missing_email_error()
    $driver.element(:id => "auth-email-missing-alert")
  end

  def missing_password_error()
    $driver.element(:id => "auth-password-missing-alert")
  end

  def missing_confirm_password_error()
    $driver.element(:id => "auth-passwordCheck-missing-alert")
  end

  def submit()
    $driver.element(:xpath => "//input[@id='continue']")
  end

  def register(name, email, password, confirmPassword)
    name().send_keys(name)
    email().send_keys(email)
    password().send_keys(password)
    confirmPassword().send_keys(confirmPassword)
    submit().click()
  end


  def navigate_to()
    sign_in_page = $page_loader.load("Sign In Page")
    sign_in_page.navigate_to();
    sign_in_page.register().click();
  end
end