module ApplicationHelper
  def sidebar_link_active?(link_text, link_path)
    @sidebar_entry ? @sidebar_entry == link_text : current_page?(link_path)
  end
end
