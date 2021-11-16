class HomeController < ApplicationController
  def index
   @data_keys = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
    ]
    @data_values = [0, 10, 5, 2, 20, 30, 45]    
  end
end
