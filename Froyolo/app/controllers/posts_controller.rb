class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  respond_to :json
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end
  
  def find_importance
    
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

  #def show_all
  #  @posts = Post.all
  #  @post = Post.first
  #end

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
    params.require(:post).permit(:xcoord, :ycoord, :altitude, :horizontalaccuracy, :verticalaccuracy, :image)
  end

  def search_params
    params.permit(:minx, :maxx, :miny, :maxy)
  end

  def change_votes_params
    params.permit(:post_id)
  end

end
