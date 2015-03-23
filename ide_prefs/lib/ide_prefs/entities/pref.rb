require "ide_prefs/entities"

class IdePrefs::Entities::Pref
  attr_reader(
    :id,
    :location,
  )

  def initialize(id: nil, location: nil, content_fetcher: ->{})
    @id = id
    @location = location
    @content_fetcher = content_fetcher
  end

  def contents
    @content_fetcher.call
  end

  def ==(other_pref)
    return false if id.nil?

    id == other_pref.id
  end

  def hash
    id.to_s.hash
  end

  def eql?(other)
    self == other
  end
end
