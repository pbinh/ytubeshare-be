class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.string :description
      t.string :metadata
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
