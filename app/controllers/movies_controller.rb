class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    # binding.pry
    if params[:title] != ""
      @movies = @movies.title_search("%#{params[:title]}%")
    end
    
    if params[:director] != ""
      @movies = @movies.director_search("%#{params[:director]}%")
    end

    if params[:duration].to_i == 1
      @movies = @movies.where('runtime_in_minutes < ?', 90)
    elsif params[:duration].to_i == 2
      @movies = @movies.where('runtime_in_minutes BETWEEN 90 AND 120')
    elsif params[:duration].to_i == 3
      @movies = @movies.where('runtime_in_minutes > ?', 120)        
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

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :poster, :remote_poster_url, :standard, :description)
  end
end
