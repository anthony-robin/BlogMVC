# Hotfix that makes Cancancan to play nicely with FriendlyId
# @example https://github.com/CanCanCommunity/cancancan/issues/106
module CanCan
  module ModelAdapters
    class AbstractAdapter
      def self.find(model_class, id)
        return model_class.friendly.find(id) if model_class.respond_to?(:friendly)
        model_class.find(id)
      end
    end
  end
end
