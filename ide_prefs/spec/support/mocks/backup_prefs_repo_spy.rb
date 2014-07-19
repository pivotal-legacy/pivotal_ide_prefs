module Spec
  module Support
    module Mocks
      class BackupPrefsRepoSpy
        def initialize(prefs: nil)
          @prefs = prefs
        end

        def all
          @prefs
        end

        def back_up_prefs(prefs)
          @backed_up = prefs
        end

        def has_backed_up_prefs?(prefs)
          prefs == @backed_up
        end
      end
    end
  end
end
