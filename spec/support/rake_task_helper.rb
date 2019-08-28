require 'rake'

module RakeTaskHelper
  extend ActiveSupport::Concern

  included do
    subject(:task) { Rake::Task[self.class.top_level_description.sub(/\Arake /, '')] }
  end
end

RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.include RakeTaskHelper, type: :task

  config.before(:suite) do
    Rails.application.load_tasks
  end
end
