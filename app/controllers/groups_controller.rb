class GroupsController < ApplicationController
	before_action :load_group, only: %i[show edit update]
  before_action :load_groups, only: %i[show]

  def index
    @groups = Group.all
  end

  def show
    @message = Message.new group: @group
    @group_messages = @group.messages.includes(:user) rescue nil
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "group #{@group.name} created successfully"
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @group.update_attributes(group_params)
      flash[:success] = "group #{@group.name} updated successfully"
    else
      render 'edit'
    end
  end

  protected

  def load_group
    @group = Group.find(params[:id]) if params[:id]
  end

  def load_groups
    @groups = Group.all
  end

  def group_params
    params.require(:group).permit(:name)
  end
end
