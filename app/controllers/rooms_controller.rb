class RoomsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @messages = Message.all
  end
end
