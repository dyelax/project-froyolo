class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  require 'open-uri'

  respond_to :json
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  def find_importance

    @posts = Post.where("xcoord > ?", search_params[:minx]).where("xcoord < ?", search_params[:maxx])
    @posts = @posts.where("ycoord > ?", search_params[:miny]).where("ycoord < ?", search_params[:maxy])

    lowest_possible_value = -3
    sum_importance = 0
    totalage = 0
    votespersecond = 1 / 36000

    @posts.each do |p|
      p.age = (Time.zone.now - p.created_at) * votespersecond
      totalage += p.age
    end

    @posts.each do |p|
      if p.age / totalage > 0.5
        p.ageadjustedscore = p.score - p.age * 2.0
      else
        p.ageadjustedscore = p.score - p.age / 2.0
      end
    end

    @posts.each do |p|
      sum_importance += (p.ageadjustedscore - lowest_possible_value)
    end

    @posts.each do |p|
      if p.ageadjustedscore < lowest_possible_value + 1
        p.importance = 0
      else
        p.importance = 100 / 93.41 * (1.0 - Math.exp( -1 * (-1.0 * lowest_possible_value + p.ageadjustedscore) / sum_importance * Math.exp(1)))
      end
    end
  end

  #POST /increment/1.json
  def increment
    @post = Post.find(change_votes_params[:post_id])
    @post.score = @post.score + 1


    respond_to do |format|
      if @post.save
        format.html {
          redirect_to @post, notice: 'Post was successfully updated.' 
          }
        format.json {
          render json: @post 
          }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  #POST /decrement/1.json
  def decrement
    @post = Post.find(change_votes_params[:post_id])
    @post.score = @post.score - 1
    respond_to do |format|
      if @post.save
        format.html {
          redirect_to @post, notice: 'Post was successfully updated.' 
          }
        format.json {
          render json: @post 
          }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def filter
  end

  def filter_results

    @posts = Post.where("xcoord > ?", search_params[:minx]).where("xcoord < ?", search_params[:maxx])
    @posts = @posts.where("ycoord > ?", search_params[:miny]).where("ycoord < ?", search_params[:maxy])

  end


  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def show_all
    @posts = Post.all
    @post = Post.first
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.score = 0



    if(post_params[:image] == nil)
      path = "#{Rails.root}/public/uploads/post/image/#{@post.id}/image.jpg"
      File.open(path, "wb") do |f|
        f.write(Base64.decode64(@post.imagedata))
      end
      @post.image = File.open(path)
    else
      @post.imagedata = Base64.encode64(File.open(@post.image.path).read)
    end

    respond_to do |format|
      if @post.save
        format.html {
          redirect_to @post, notice: 'Post was successfully created.' 
          }
        format.json {
          render json: @post 
          }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:xcoord, :ycoord, :altitude, :horizontalaccuracy, :verticalaccuracy, :image, :imagedata)
  end

  def search_params
    params.permit(:minx, :maxx, :miny, :maxy)
  end

  def change_votes_params
    params.permit(:post_id)
  end

end
