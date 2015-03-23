require "ide_prefs/entities/pref"
require "securerandom"

class FakePrefFactory
  def generate_pref
    id = SecureRandom.uuid

    IdePrefs::Entities::Pref.new(
      id: id,
      location: "/some/location/#{id}",
      content_fetcher: -> { id },
    )
  end
end
