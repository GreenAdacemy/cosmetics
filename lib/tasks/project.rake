namespace :project do
  desc 'call and generater sample data for project'
  task sample: :environment do
    Rake::Task['user:init'].invoke
    Rake::Task['product:init'].invoke
  end
end
