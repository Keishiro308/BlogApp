class UsersController < ApplicationController
  before_action :authenticate_user, {only:[:show,:edit,:update,:index]}
  before_action :forbid_login_user, {only:[:login_form,:login,:create,:new]}
  before_action :ensure_correct_user, {only:[:edit,:update,:follow]}


  def index
  end

  def login_form
  end

  def new
  end

  def create
    @user=User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: 'defoult.jpg',
      profile: params[:profile]
    )
    if @user.save
      session[:user_id]=@user.id
      flash[:notice]="登録が完了しました。"
      redirect_to("/")
    else
      render("users/new")
    end
  end

  def login
    @user=User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      flash[:notice]="ログインしました。"
      redirect_to("/")
    else
      @email=params[:email]
      @password=params[:password]
      flash[:notice]="メールアドレスまたはパスワードが間違っています。"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました。"
    redirect_to("/login")
  end

  def show
    @user=User.find_by(id: params[:id])
    @posts=@user.posts.page(params[:page]).per(PER).order(id:"DESC")
  end

  def edit
    @user=User.find_by(id: params[:id])
  end

  def update
    @user=User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.profile = params[:profile]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice]="編集できました。"
      redirect_to("/users/#{@user.id}")
    end
  end

  def follow
    @author_id = []
    @current_user.follows.each do |follow|
      @author_id.append(follow.author_id)
    end
    @posts = Post.where(user_id: @author_id).page(params[:page]).per(PER).order(created_at: 'DESC')
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません。"
      redirect_to("/posts")
    end
  end

end
