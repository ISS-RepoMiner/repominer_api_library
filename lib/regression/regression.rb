# require 'narray' # gem install narray

# make linear regression model
class LinearRegressor
  def initialize(data_x, data_y)
    @data_x = data_x
    @data_y = data_y
    @x_mean = data_x.inject(0.0) { |sum, el| sum + el } / data_x.size
    @y_mean = data_y.inject(0.0) { |sum, el| sum + el } / data_y.size
  end

  def alpha
    @y_mean - (beta * @x_mean)
  end

  def beta
    delta_xy / delta_x_square
  end

  def delta_xy
    delta_x = delta(@data_x, @x_mean)
    delta_y = delta(@data_y, @y_mean)
    delta_x.zip(delta_y).map { |x, y| x * y }.sum
  end

  def delta(n_array, mean)
    n_array.map do |value|
      value - mean
    end
  end

  def delta_x_square
    delta(@data_x, @x_mean).map {|num| num ** 2}.sum
  end
end
