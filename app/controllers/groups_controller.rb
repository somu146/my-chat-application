class GroupsController < ApplicationController
	before_action :load_group, only: %i[show edit update]
  before_action :load_groups, only: %i[show index]
  
  def index 
  end 

  def show
    if @group.is_private?
      if @group.participants.collect(&:user_id).include?(current_user.id)
        @message = Message.new group: @group
        @group_messages = @group.messages.includes(:user) rescue nil
        @participants = @group.participants.where.not(user_id: current_user.id)
      else
        @error = "Group is Private"
      end
    else
      @message = Message.new group: @group
      @group_messages = @group.messages.includes(:user) rescue nil
    end
  end

  def new
    @group = Group.new
  end

  def create
    if group_params[:is_private] == '1'
      @group = Group.new(group_params)
      if @group.save
        users = User.where(id: params[:users]) if params[:users].present?
        @group.create_participants(users) if users.present?
        redirect_to groups_path
      else
        render 'new'
      end
    else
      @group = Group.new(group_params)
      if @group.save
        flash[:success] = "group #{@group.name} created successfully"
        redirect_to groups_path
      else
        render 'new'
      end
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
    @public_groups = Group.where(is_private: false)
    @private_groups = current_user.groups
  end

  def group_params
    params.require(:group).permit(:name, :is_private)
  end
end
