class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :place
      t.text :address
      t.text :description
      t.datetime :date
      t.string :url
      t.float :lat
      t.float :long
    end
  end
end
