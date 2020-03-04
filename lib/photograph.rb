class Photograph
  attr_reader :id, :name, :artist_id, :year

  def initialize(photograph_params)
    @id = photograph_params[:id]
    @name = photograph_params[:name]
    @artist_id = photograph_params[:artist_id]
    @year = photograph_params[:year]
  end
end
