require_relative "./common_page_object.rb"

class HomePage < CommonPageObject

  def sign_in_link()
    primary = $driver.link(:id => "nav-link-accountList")
    if (primary.exists?)
      primary
    else
      $driver.link(:id => "nav-link-yourAccount")
    end
  end

  def greeting()
    $driver.element(:id => "hud-customer-name")
  end

  def navigate_to()
    $driver.goto($HOME_URL);
  end
end