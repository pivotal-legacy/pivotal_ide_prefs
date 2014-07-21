module Spec
  module Support
    module Mocks
      class UserPrefsRepoSpy
        def initialize(matching_uninstalled_prefs: nil)
          @matching_uninstalled_prefs = matching_uninstalled_prefs
        end

        def find_matching_uninstalled_prefs(*)
          @matching_uninstalled_prefs
        end

        def install_prefs(prefs)
          @installed = prefs
        end

        def copy_prefs(prefs)
          @copied = prefs
        end

        def has_copied?(prefs)
          @copied == prefs
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
