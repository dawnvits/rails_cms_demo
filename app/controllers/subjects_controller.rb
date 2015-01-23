class SubjectsController < ApplicationController

  before_action :authenticate_user!

  def index
    @subjects = Subject.sorted.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully!"
      redirect_to subject_path(@subject.id)
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)
      flash[:notice] = "Subject updated successfully!"
      redirect_to subject_path
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject destroyed successfully!"
    redirect_to subjects_path
  end


  private

    def subject_params
      params.require(:subject).permit(:name, :position, :visible)
    end


end