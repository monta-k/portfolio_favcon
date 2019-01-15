module ApplicationHelper
  def devise_error_messages
    return "" if resource.errors.empty?
    html = ""
    # エラーメッセージ用のHTMLを生成
    resource.errors.full_messages.each do |msg|
      html += <<-EOF
          <p>#{msg}</p>
      EOF
    end
    html.html_safe
  end
end
