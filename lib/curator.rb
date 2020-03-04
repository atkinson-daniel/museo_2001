require 'csv'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find {|artist| artist.id == id}
  end

  def photographs_by_artist
    @photographs.reduce({}) do |artist_by_photos, photo|
      artist = find_artist_by_id(photo.artist_id)
      artist_by_photos[artist] = [] if artist_by_photos[artist].nil?
      artist_by_photos[artist] << photo
      artist_by_photos
    end
  end

  def artists_with_multiple_photographs
    photographs_by_artist.map do |artist, photographs|
      artist.name if photographs.length > 1
    end.compact
  end

  def photographs_taken_by_artist_from(country)
    photographs_by_artist.flat_map do |artist, photographs|
      photographs if artist.country == country
    end.compact
  end

  def load_photographs(filepath)
    csv = CSV.read("#{filepath}", headers: true, header_converters: :symbol)
    csv.map do |row|
      @photographs << Photograph.new(row)
    end
  end

  def load_artists(filepath)
    csv = CSV.read("#{filepath}", headers: true, header_converters: :symbol)
    csv.map do |row|
     @artists << Artist.new(row)
   end
  end

  def photographs_taken_between(date_range)
    @photographs.find_all do |photo|
      date_range.to_a.include?(photo.year.to_i)
    end
  end

  def artists_photographs_by_age(artist)
    artist_photos = photographs_by_artist[artist]
    artist_photos.reduce({}) do |age_by_photo, photo|
      age = photo.year.to_i - artist.born.to_i
      age_by_photo[age] = photo.name
      age_by_photo
    end
  end
end
