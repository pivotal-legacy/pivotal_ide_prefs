module Spec
  module Support
    module Mocks
      class MockBackupPrefsRepo
        def initialize(prefs: [])
          @prefs = prefs
        end

        def all
          @prefs
        end

        def back_up_prefs(prefs)
          @prefs += prefs
        end
      end
    end
  end
end
