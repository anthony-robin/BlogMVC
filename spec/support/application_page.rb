# Page objects support.
class ApplicationPage
  include Capybara::DSL

  def trigger_focus_event(selector)
    script = "document.getElementById('#{selector}').focus()"
    page.execute_script(script)
  end
end
