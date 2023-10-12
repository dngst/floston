class HomeController < ApplicationController
  def index
    @home_page = true
    render
  end
end
