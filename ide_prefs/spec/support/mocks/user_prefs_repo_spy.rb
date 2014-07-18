module Spec
  module Support
    module Mocks
      class UserPrefsRepoSpy
        def initialize(matching_prefs: nil)
          @matching_prefs = matching_prefs
        end

        def find_matching_prefs(*)
          @matching_prefs
        end

        def install_prefs(prefs)
          @installed = prefs
        end

        def has_installed_prefs?(prefs)
          prefs == @installed
        end
      end
    end
  end
end
