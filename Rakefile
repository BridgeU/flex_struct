require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new do |t|
  t.options = %w[--format simple --fail-level warning]
end

task default: %i[spec rubocop]
