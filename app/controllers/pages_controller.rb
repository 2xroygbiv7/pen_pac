class PagesController < ApplicationController
  def index
    @q = Invoice.ransack(params[:q])
    @result = @q.result
  end
end
