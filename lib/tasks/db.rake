namespace :db do
  desc "Re-Create database, db:drop, db:create, db:migrate, db:seed"
  task __recreate__: ["db:drop", "db:create", "db:migrate", "db:seed", "db:test:prepare"]
  task recreate: :environment do
    if Rails.env.development?
      Rake::Task["db:__recreate__"].invoke
    else
      STDERR.puts "Oops! db:recreate task can be executed only in the development environment."
    end
  end
end
