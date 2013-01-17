class ItemsController < ApplicationController
  
  def create    
    if @object = List.find(params[:list_id]).items.find_or_create_by_url(params[:item])
      redirect_to request.referer
    end
  end
  
  def destroy
    object.destroy
    redirect_to request.referer
  end
end
