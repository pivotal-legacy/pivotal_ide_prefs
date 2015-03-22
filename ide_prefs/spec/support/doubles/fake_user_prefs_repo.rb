module Spec
  module Support
    module Doubles
      class FakeUserPrefsRepo
        attr_reader(
          :installed_prefs,
        )

        def initialize(matching_uninstalled_prefs: nil, prefs: [], installed_prefs: [])
          @matching_uninstalled_prefs = matching_uninstalled_prefs
          @prefs = prefs
          @installed_prefs = installed_prefs
        end

        def all
          @prefs + @installed_prefs
        end

        def find_matching_uninstalled_prefs(*)
          @matching_uninstalled_prefs
        end

        def install_prefs(prefs)
          @installed_prefs += prefs
        end

        def copy_prefs(prefs)
          @prefs += prefs
        end

        def destroy_installed_prefs
          @installed_prefs = []
        end
      end
    end
  end
end
