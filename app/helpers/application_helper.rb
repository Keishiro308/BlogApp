module ApplicationHelper

  def partial_stylesheet_link_tag(controller_name, disabled = false)
    if disabled == false || disabled.nil?
      if File.exist?("#{Rails.root.to_s}/app/assets/stylesheets/#{controller_name}/#{controller_name}.scss")
        return stylesheet_link_tag "#{controller_name}/#{controller_name}"
      end
    end
  end

  def trix_stylesheet_link_tag(disabled = true)
    if disabled == false
      if File.exist?("#{Rails.root.to_s}/app/assets/stylesheets/#{controller_name}/actiontext.scss")
        return stylesheet_link_tag "#{controller_name}/actiontext"
      end
    end
  end

end
