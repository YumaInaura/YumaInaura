class HelloController < ApplicationController
  def index
    render json: {
      message: "Hello",
      time: Time.current
    }
  end
end