class WelcomeController < ApplicationController

  def index
    @intros = Intro.published
  end

end
