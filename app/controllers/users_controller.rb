class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
<<<<<<< HEAD
    if( !current_user.role?(:admin))
      redirect_to login_url and return
    end
    @users = User.all
=======
    if(current_user.role == "guest" or current_user.role == "coach" )
      redirect_to login_url and return
    end
       @users = User.all
>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if( !current_user.role?(:admin))
      redirect_to login_url and return
    end
  end

  # GET /users/new
<<<<<<< HEAD
  def new
    if( !current_user.role?(:admin))
      redirect_to login_url and return
    end
    @user = User.new
=======
  def new  
    if(current_user.role == "guest" or current_user.role == "coach" )
      redirect_to login_url and return
    end
       @user = User.new

>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
  end

  # GET /users/1/edit
  def edit
<<<<<<< HEAD
    if( !current_user.role?(:admin))
      redirect_to login_url and return
    end
    @user = current_user
=======
    if(current_user.role == "guest" or current_user.role == "coach" )
      redirect_to login_url and return
    end
      @user = current_user

>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
  end

  # POST /users
  # POST /users.json
  def create
<<<<<<< HEAD
    if( !current_user.role?(:admin))
=======
    if(current_user.role == "guest" or current_user.role == "coach" )
>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
      redirect_to login_url and return
    end
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, 
          notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
<<<<<<< HEAD
    if( !current_user.role?(:admin))
=======
    if(current_user.role == "guest" or current_user.role == "coach" )
>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
      redirect_to login_url and return
    end
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
<<<<<<< HEAD
    if( !current_user.role?(:admin))
=======
    if(current_user.role == "guest" or current_user.role == "coach" )
>>>>>>> b6f3e80c20954755ed1fda1fc8d5e53ad89077e5
      redirect_to login_url and return
    end
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if( !current_user.role?(:admin))
        redirect_to login_url and return
      end
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name,
                                   :role, 
                                   :password,
                                   :password_confirmation,
                                   :active)
    end
end
