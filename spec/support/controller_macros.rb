module ControllerMacros
  def sign_in(email, password)
    first("input[type='email']").set(email)
    first("input[type='password']").set(password)
    click_button "Log in"
  end

  def sign_up(username, email, password, password_confirmation)
    fill_in "user_username", with: username
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password_confirmation
    click_button "Sign up"
  end
end
