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

        def create_prefs(prefs)
          @created = prefs
        end

        def has_created?(prefs)
          @created == prefs
        end

        def destroy_installed_prefs
          @destroyed_installed_prefs = true
        end

        def has_destroyed_installed_prefs?
          @destroyed_installed_prefs
        end

        def has_installed_prefs?(prefs)
          prefs == @installed
        end
      end
    end
  end
end
