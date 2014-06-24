module CivilityTracker
  module Configuration
    extend ActiveSupport::Concern
    included do
      helper_method :title
      helper_method :body_class
    end

    def title
      "Civility Tracker"
    end

    def body_class
      ""
    end

  end
end
