class ListsController < ApplicationController
  
  def index
    
  end
  
  def new
    @object = current_user.lists.for_profession(profession).new
  end
  
  def create
    @object = current_user.lists.new({:profession_id => profession.id}.merge(params[:list]))
    if @object.save
      redirect_to profession_lists_url(profession)
    else
      flash[:alert] = "There was an error"
      render :new
    end
  end
  
  def object
    @object ||= current_user.lists.find(params[:ids])
    @profession = @object.profession
  end
  
  def collection
    @collection ||= current_user.lists.for_profession(profession)
  end
  
  def profession
    @profession ||= Profession.find(params[:profession_id])
  end
end
