class ListsController < ApplicationController
  
  def index
    
  end
  
  def new
    @object = current_user.lists.for_profession(profession).new
  end
  
  def create
    @object = current_user.lists.new({:profession_id => profession.id}.merge(params[:list]))
    if @object.save
      @object.spider_spidy_search(params[:search]) if params[:search]
      redirect_to profession_lists_url(profession)
    else
      flash[:alert] = "There was an error"
      render :new
    end
  end
  
  def craft
    collection
    @items = collection.map(&:items).flatten
    @shopping_list = collection.map &:shopping_list
    
    @shopping_list_by_component = {}
    @shopping_list.each do |list|
      list.each do |item, instructions|
        instructions.each do |instruction, components|
          components.each do |component|
            @shopping_list_by_component[instruction]||={}
            @shopping_list_by_component[instruction][component.component.id] ||= {} 
            @shopping_list_by_component[instruction][component.component.id][:needed] ||= 0
            @shopping_list_by_component[instruction][component.component.id][:needed] += component.needed
            @shopping_list_by_component[instruction][component.component.id][:price_each] ||= 0
            @shopping_list_by_component[instruction][component.component.id][:price_each] += component.component.crafting_cost
            @shopping_list_by_component[instruction][component.component.id][:object] ||= component
          end
        end
      end
    end
  end

  def craft_selected
    @items = params[:items].split(',').map{|i| Item.find(i.to_i)}
    @shopping_list = @items.collect{|i| i.recipe.shopping_list_by_component}
    @shopping_list_by_component = {}
    @shopping_list.each do |instructions|
      instructions.each do |instruction, components|
        components.each do |component_id, list|
          # raise component.inspect

          @shopping_list_by_component[instruction]||={}
          @shopping_list_by_component[instruction][component_id] ||= {} 
          @shopping_list_by_component[instruction][component_id][:needed] ||= 0
          @shopping_list_by_component[instruction][component_id][:needed] += list[:needed]
          @shopping_list_by_component[instruction][component_id][:price_each] ||= 0
          @shopping_list_by_component[instruction][component_id][:price_each] = list[:price_each]
          @shopping_list_by_component[instruction][component_id][:object] ||= list[:object]
        end
      end
    end
    
    @profession = Profession.find params[:profession_id]
    render :craft
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
