class PostsController < ApplicationController
  before_action :set_post, {only: [:show, :edit, :update, :destroy]}
  before_action :authenticate_user
  before_action  :ensure_correct_user, {only: [:edit, :update, :destroy]}


  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.includes(:tags).all.page(params[:page]).per(PER).order(id:"DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = Comment.where(post_id: params[:id])
    @post = Post.find_by(id:  params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
    @trix_css_disabled=false
  end

  # GET /posts/1/edit
  def edit
    @trix_css_disabled=false

  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(title: post_params[:title], content: post_params[:content],user_id: @current_user.id, tags_as_string: post_params[:tags_as_string])
    if @post.save
      if post_params[:article_image]
        @post.article_image = "#{@post.id}.jpg"
        image = post_params[:article_image]
        File.binwrite("public/article_images/#{@post.article_image}", image.read)
        @post.save
      else
        @post.article_image = "no_image.jpg"
        @post.save
      end
      flash[:notice]="投稿できました。"
      redirect_to("/posts/#{@post.id}")
    else
      if params[:title] == nil
        flash[:notice] =  "タイトルを入力してください。"
        render("posts/new")
      elsif params[:content] == nil
        flash[:notice] = "本文を入力してください。"
        render("posts/new")
      end
    end
    #
    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to @post, notice: '投稿できました。'}
    #     format.json { render :show, status: :created, location: @post }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.title = post_params[:title]
    @post.content = post_params[:content]
    @post.tags_as_string = post_params[:tags_as_string]
    if post_params[:article_image]
      @post.article_image = "#{@post.id}.jpg"
      image = post_params[:article_image]
      File.binwrite("public/article_images/#{@post.article_image}", image.read)
    end
    # @post.save
    if @post.save
      flash[:notice]="投稿は編集されました。"
      redirect_to("/posts/#{@post.id}")
    end
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: '投稿は編集されました。' }
    #     format.json { render :show, status: :ok, location: @post }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿は削除されました。' }
      format.json { head :no_content }
    end
  end

  def result
  end

  def tag
    @posts=Post.tagged_with(:names => params[:tag_name], :match => :all).includes(:tags).page(params[:page]).per(PER).order(id:"DESC")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :article_image,:tags_as_string)
    end

    def ensure_correct_user
      @post=Post.find_by(id: params[:id])
      if @post.user_id != @current_user.id
        flash[:notice]="権限がありません。"
        redirect_to("/posts")
      end
    end

end
