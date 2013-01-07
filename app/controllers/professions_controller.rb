class ProfessionsController < ApplicationController
  
  def index
    collection
  end
  
  def new
    
  end
  
  def create
    @object = Profession.new(params[:profession])
    if @object.save
      redirect_to professions_url
    else
      flash[:alert] = "There were errors"
      render :new
    end
  end
  
  def destroy
    if object.destroy
      flash[:notice] = "Profession removed"
      redirect_to professions_url
    else
      flash[:alert] = "Unable to remove profession"
      redirect_to professions_url
    end
  end
end
