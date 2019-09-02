require 'rake'

module RakeTaskHelper
  extend ActiveSupport::Concern

  included do
    subject(:task) { Rake::Task[self.class.top_level_description.sub(/\Arake /, '')] }
    let(:task_args) { TaskArgs = Struct.new(*task.arg_names) }
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
