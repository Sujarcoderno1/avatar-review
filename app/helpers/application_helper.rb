module ApplicationHelper

  def fa_icon type
    ('<i class="fa fa-<%=type%>"></i>').html_safe
  end
end
