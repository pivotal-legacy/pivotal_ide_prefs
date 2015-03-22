require "ide_prefs/entities/pref"
require "tempfile"
require "securerandom"

class PrefFactory
  def generate_pref
    file = Tempfile.new('pref')

    file.write(SecureRandom.uuid)

    IdePrefs::Entities::Pref.new(
      id: File.basename(file),
      location: file.path,
      content_fetcher: -> { File.read(file.path) }
    )
  end
end
