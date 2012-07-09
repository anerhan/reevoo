require 'active_record/fixtures'

module ActiveRecord
  class Migration
    def load_data(filename, dir = 'db/init')
      Fixtures.create_fixtures(File.join(Rails.root, dir), filename)
    end
  end
end