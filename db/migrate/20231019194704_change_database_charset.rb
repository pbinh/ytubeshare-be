class ChangeDatabaseCharset < ActiveRecord::Migration[7.1]
  def up
    execute 'ALTER DATABASE `ytubeshare` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;'
  end

  def down
    execute "ALTER DATABASE `ytubeshare` CHARACTER SET latin1 COLLATE latin1_swedish_ci"
  end
end
