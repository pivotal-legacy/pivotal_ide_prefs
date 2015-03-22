module Spec
  module Support
    module Doubles
      class FakePivotalPrefsRepo
        attr_reader :all

        def initialize(prefs: nil)
          @all = prefs
        end
      end
    end
  end
end
