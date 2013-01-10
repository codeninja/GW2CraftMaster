class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user! 
  
  before_filter :object , :only =>[ :show, :update ]
  before_filter :collection, :only => :index
  before_filter :create_new_object, :only => :new
  
  
  def site_index
    
  end
  
  def index
    render :text => "#{self.action_name} Not Implemented"
  end
  
  def new
    render :text => "#{self.action_name} Not Implemented"
  end
  
  def show
    render :text => "#{self.action_name} Not Implemented"
  end
  
  def update
    render :text => "#{self.action_name} Not Implemented"
  end
  
  def create
    render :text => "#{self.action_name} Not Implemented"
  end
  
  def object_name
    self.controller_name.singularize.camelize.constantize
  end
  
  def create_new_object(options={})
    @object ||= object_name.new(options)
  end
  
  def object
    @object ||= object_name.find(params[:id])
  end
  
  def collection
    @collection ||= object_name.all
  end
  
end
