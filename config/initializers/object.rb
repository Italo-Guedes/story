# frozen_string_literal: true

if Rails.env.production?
  # Object fake class to prevent byebugs in production
  class Object
    def byebug; end
  end

  # Binding fake to prevent binding.pry in production
  class Binding
    def pry; end
  end
end
