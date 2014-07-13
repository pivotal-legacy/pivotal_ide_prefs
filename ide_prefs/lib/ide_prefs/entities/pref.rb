require "ide_prefs/entities"

class IdePrefs::Entities::Pref
  attr_reader(
    :id,
    :location,
  )

  def initialize(id: nil, location: nil)
    @id = id
    @location = location
  end

  def ==(other_pref)
    return false if id.nil?

    id == other_pref.id
  end
end
