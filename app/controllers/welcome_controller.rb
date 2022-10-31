class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "curso de rails"
    @nome = params[:nome]
  end
end
