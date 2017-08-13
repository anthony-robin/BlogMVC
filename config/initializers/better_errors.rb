# BetterErrors hack to fix slow page rendering
# https://github.com/charliesome/better_errors/issues/334#issuecomment-226464620
#
module BetterErrorsHugeInspectWarning
  def inspect_value(obj)
    inspected = obj.inspect
    if inspected.size > 100_000
      inspected = "Object was too large to inspect (#{inspected.size} bytes). " \
        "Implement #{obj.class}#inspect if you need the details."
    end
    CGI.escapeHTML(inspected)
  rescue NoMethodError
    "<span class='unsupported'>(object doesn't support inspect)</span>"
  rescue Exception
    "<span class='unsupported'>(exception was raised in inspect)</span>"
  end
end

if defined?(BetterErrors)
  BetterErrors::ErrorPage.prepend(BetterErrorsHugeInspectWarning)

  # Other preset values are [:mvim, :macvim, :textmate, :txmt, :tm, :sublime, :subl, :st]
  BetterErrors.editor = 'atm://open?url=file://%{file}&line=%{line}'
end
