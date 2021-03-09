class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :single_yacht, only: %i[show book review edit destroy]
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

  private

  def single_yacht
    @yacht = Yacht.find(params[:id])
  end
end
