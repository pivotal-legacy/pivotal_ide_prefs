module Spec
  module Support
    module Mocks
      class BackupPrefsRepoSpy
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
