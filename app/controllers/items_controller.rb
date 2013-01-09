class ItemsController < ApplicationController
  
  def create
    
    @object = List.find(params[:list_id]).items.new(params[:item])
    if @object.save
      redirect_to request.referer
    end
  end
end
