class MoviesController < ApplicationController
  def index
    @movies = Movie.all
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
