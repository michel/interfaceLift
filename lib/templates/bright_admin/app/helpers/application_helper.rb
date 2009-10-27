# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def dasboard_tab?
    "current"
  end  
  
  def on_tab_for?(controller)
    params[:controller] == controller ? "current" : ""
  end
  
end
