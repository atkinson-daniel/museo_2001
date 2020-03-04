class Artist
  attr_reader :id, :name, :born, :died, :country

  def initialize(artist_params)
    @id = artist_params[:id]
    @name = artist_params[:name]
    @born = artist_params[:born]
    @died = artist_params[:died]
    @country = artist_params[:country]
  end

  def age_at_death
    @died.to_i - @born.to_i
  end
end
