module ApplicationHelper

  def errors_for(object, message=nil)
    html = ""
    unless object.errors.blank?
      html << "<div class='formErrors #{object.class.name.humanize.downcase}Errors'>\n"
      if message.blank?
        if object.new_record?
          html << "\t\t<h5>There was a problem creating the #{object.class.name.humanize.downcase}</h5>\n"
        else
          html << "\t\t<h5>There was a problem updating the #{object.class.name.humanize.downcase}</h5>\n"
        end    
      else
        html << "<h5>#{message}</h5>"
      end  
      html << "\t\t<ul>\n"
      object.errors.full_messages.each do |error|
        html << "\t\t\t<li>#{error}</li>\n"
      end
      html << "\t\t</ul>\n"
      html << "\t</div>\n"
    end
    html
  end  
  
  # assumes 1234.56
  def h_to_gold(amount = 0)
    amount = amount.to_f
  
    # calc
    g = (amount/100).to_i
    s = (amount - (g*100)).to_i
    c = ((amount - amount.to_i)*100).to_i
    
    # format
    g = g != 0 ? "#{g}<span class='gold'>g</span>" : ''
    s = s != 0 ? "#{s}<span class='silver'>s</span>" : ""
    c = c != 0 ? "#{c}<span class='copper'>c</span>" : ""
    
    raw "#{g} #{s} #{c}"
  end
end
