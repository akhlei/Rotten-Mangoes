class MoviesController < ApplicationController
  def index
    #TODO 
    # Implement runtime search utilising params[:runtime_in_minutes] 
    # Whats the best way to approach utilising all 3... 
    # All the if/elsif/else statements are extremely clunky 



    if params[:search]
      @movies = Movie.where("title like ? OR director like ?", params[:search], params[:search])
    elsif params[:runtime_in_minutes]
      @movies = Movie.where("runtime_in_minutes")
    else
      @movies = Movie.all
    end


  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end


  # need a search action to do something. Here is where I would put my query options
  def search

  end

  # @movie is a new movie passing in the parameters from this create page
  # if it properly saves, go to the all movies page, otherwise go to the 'new' page again
  def create
    @movie = Movie.new(movie_params)
    @movie.poster = params[:poster]

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was successfully submitted!"
    else
      render :new
    end
  end 

  # @movie is a specific movie that matches the correct id
  # if the movie properly saves, go to the path for that movie, otherwise redirect to the 'edit' page
  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movies_path(@movie)
    else
      render :edit 
    end
  end

  # @movie is again a specific movie because you only want to delete an individual movie
  # call destroy, and then redirect to the all movies path 
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  # made to pass in the parameters needed for a movie more easily in other parts of my code 
  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster, :description
    )
  end
end
