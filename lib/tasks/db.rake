
namespace :db do

  #Add This line in tasks for working with compiled stylesheets, javascripts and static images 'assets:clean','assets:precompile',
  desc 'Drops all, creates all, migrates reset and then init All databases'
  task :make =>  ['db:drop:all', 'db:create:all', 'db:migrate:reset', 'db:init']

  desc 'Load all fixtures from db/init'
  task :init do
    puts "==  Loading Init Fixtures  ====================================================\n"
    time = Benchmark.measure do
      Dir.glob(File.join(Rails.root, 'db', 'init', "*.yml")).each do |f|
        table_name = f.gsub(File.join(Rails.root, 'db', 'init', ''), '').gsub('.yml', '')
        begin
          ActiveRecord::Migration.load_data(table_name)
          puts(" [ loaded ] From: /db/init/#{table_name}.yml\n")
        rescue Exception => e
          puts "[ Not loaded! ] From: /db/init/#{table_name}.yml Explain: \n\n #{e.message}\n\n"
        end
      end
    end
    puts "==  End Loading Init Fixtures (#{"%.4fs"%time.real})  ========================================\n"
  end
end


