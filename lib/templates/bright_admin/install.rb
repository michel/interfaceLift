puts "Placing helper methods in ApplicationHelper"
gsub_file("/app/helpers/application_helper.rb", /ApplicationHelper/) do |match|
   "#{match}      
   
   def dasboard_tab?
     \"current\"
   end  

   def on_tab_for?(controller)
     params[:controller] == controller ? \"current\" : \"\"
   end
   "
end