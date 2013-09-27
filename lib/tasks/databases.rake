namespace :db do
  task :load_config do
    ActiveRecord::Tasks::DatabaseTasks.fixtures_path = Rails.root.join('spec', 'fixtures')
  end
end
