class StatisticsController < ApplicationController
  def index
    @results = Result.all
  end

  def show
    @result = Result.find(params[:id])
  end
end
