# frozen_string_literal: true

module NavbarHelper
  def nav_link_class_for(nav_link)
    classes = []
    classes << 'nav-link'
    classes << 'active' if nav_link == content_for(:active_tab)
    classes.join ' '
  end
end
