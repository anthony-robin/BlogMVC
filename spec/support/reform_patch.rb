# Patch `Reform::Form` class to readd `valid?` method
# as `shoulda-matchers` relies on it.
module Reform
  class Form
    # Checks if form is valid
    #
    # @return [Boolean]
    def valid?
      validate({})
    end
  end
end
