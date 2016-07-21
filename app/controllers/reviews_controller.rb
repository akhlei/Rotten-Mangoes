class ReviewsController < ApplicationController
  before_filter :restrict_access
  before_filter :load_movie  #loads the parent resource to reviews, which is nested in movies as a reference

  def new
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.build   #equivalent to @review = Review.new(movie_id: @movie.id)
  end

  def create
    movie = Movie.find(params[:movie_id])
    review = movie.reviews.build(review_params)
    review.user_id = current_user.id

    if review.save
      redirect_to @movie, notice: "Review created successfully"
    else
      render :new
    end
  end

  protected 

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end

end
