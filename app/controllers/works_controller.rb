class WorksController < ApplicationController
  def index
    @works = Work.all
  end


  def show
    work_id = params[:id]
    find_work
    if @work.nil?
      head :not_found
    end
  end

  def new
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      @work = user.works.new
      # Same thing as above:
      # @work = Work.new(user: user)
    else
      @work = Work.new
    end
  end

  def create
    filtered_work_params = work_params()
    @work = Work.new(filtered_work_params)

    is_successful_save = @work.save

    if is_successful_save
      flash[:success] = "Successfully created new work with title \"#{@work.title}\""
      redirect_to works_path
    else
      flash.now[:error] = "Invalid work data"
      render :new, status: :bad_request
    end
  end


  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated work \"#{@work.title}\""
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Invalid work data"
      render(:edit, status: :bad_request)
    end
  end

  def upvote
<<<<<<< HEAD
    work = params[:id]
    if user_id = session[:user_id]
      vote.user_id = user_id

    else
      flash.now[:error] = "Must be logged in to vote!"
      render :new
=======
    if user_id != session[:user_id]
      flash[:error] = "Must be logged in to vote!"
    elsif
      user_id == session[:user_id]
      @votes = []
      vote = Vote.new
      vote.work_id = params[:id]
      vote.user_id = user_id
      @votes << vote
      @votes.each do |vote|
        if session[:user_id] == vote.user_id
          flash[:error] = "Cannot Vote on a work twice!"
          render :new
        end
      end
>>>>>>> controllers
    end
  end

  def destroy
    if @work.user_id == session[:user_id]
      @work.destroy

      flash[:success] = "Successfully destroyed work \"#{@work.title}\""
      redirect_to works_path

    else
      flash[:error] = "You must be logged in as a work's user in order to delete it!"

      redirect_back(fallback_location: root_path)
    end
  end

  private

  # Strong params: only let certain attributes
  # through
  def work_params
    return params.require(:work).permit(
      :title,
      :creator,
      :description,
      :publication_year,
      :category
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
<<<<<<< HEAD
=======
end
>>>>>>> controllers
