class AboutsController < ApplicationController
  skip_before_action :ensure_current_user

  def show
    render :about
  end
end