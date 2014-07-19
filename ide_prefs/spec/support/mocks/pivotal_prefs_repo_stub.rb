module Spec
  module Support
    module Mocks
      class PivotalPrefsRepoStub
        attr_reader :all

        def initialize(prefs: nil)
          @all = prefs
        end
      end
    end
  end
end
