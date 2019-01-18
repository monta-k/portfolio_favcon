module ControllerMacros
  def sign_in_fill(email, password)
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

  def login(email, password)
    first("input[type='email']").set(email)
    first("input[type='password']").set(password)
    click_button "Log in"
  end

  def user_information_edit(username, email)
    fill_in "user_username", with: username
    fill_in "user_email", with: email
    choose "user_sex_男性"
    click_button "変更する"
  end

  def password_edit(current_password, new_password, password_confirmation)
    fill_in "user_current_password", with: current_password
    fill_in "user_password", with: new_password
    fill_in "user_password_confirmation", with: password_confirmation
    click_button "変更する"
  end
end
