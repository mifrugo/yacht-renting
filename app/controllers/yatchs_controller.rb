class YatchsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
  end

  def show
  end

  def book
  end

  def review
  end

  def create
  end

  def edit
  end

  def destroy
  end
end