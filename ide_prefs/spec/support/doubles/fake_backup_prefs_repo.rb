module Spec
  module Support
    module Doubles
      class FakeBackupPrefsRepo
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
