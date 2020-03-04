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
    artists_collection = @artists.reduce({}) do |accum, artist|
      accum[artist] = []
      accum
    end

    @photographs.each do |photograph|
      artist = find_artist_by_id(photograph.artist_id)
      artists_collection[artist] << photograph
    end
    artists_collection
  end

  def artists_with_multiple_photographs
    found = photographs_by_artist.select do |artist, photographs|
      photographs.length > 1
    end

    found.map {|artist, photographs| artist.name}
  end

  def photographs_taken_by_artist_from(country)
    found = photographs_by_artist.select do |artist, photographs|
      artist.country == country
    end

    found.flat_map {|artist, photographs| photographs}
  end
end
