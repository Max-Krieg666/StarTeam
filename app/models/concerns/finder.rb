module Finder
  extend ActiveSupport::Concern

  included do
    def self.find(input)
      return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
      return find_by(title: input.tr('+', ' ')) if self.column_names.include?('title')
      return find_by(name: input.tr('+', ' ')) if self.column_names.include?('name')

      find_by(login: input.tr('+', ' '))
    end
  end
end
