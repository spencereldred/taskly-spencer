class AboutsController < ApplicationController
  skip_before_action :ensure_current_user

  def show

  end
end