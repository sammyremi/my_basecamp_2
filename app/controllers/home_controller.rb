class HomeController < ApplicationController
  def index
    if signed_in?
      redirect_to projects_path
    end
  end

  def error
  end
end
