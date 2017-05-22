module SessionHelper
  def active_tab(tab)
    "active" if @active_tab == tab
  end
end
