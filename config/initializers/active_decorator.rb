ActiveSupport::Reloader.to_prepare do
  ActiveDecorator::Decorator.class_variable_set :@@decorators, {}
end