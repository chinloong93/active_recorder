class TablesController < ApplicationController
  # GET /tables
  def index
    @users = User.all
    @statuses = Status.all
    @groups = Group.all
    @groupsusers = GroupsUser.all
  end
end
