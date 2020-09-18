module Finder
  extend ActiveSupport::Concern

  def self.find(input)
    return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
    return find_by(title: input.tr('+', ' ')) if self.class.method_defined?(:title)
    return find_by(name: input.tr('+', ' ')) if self.class.method_defined?(:name)

    find_by(login: input.tr('+', ' '))
  end
end
