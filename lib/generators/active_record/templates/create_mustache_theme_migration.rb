class CreateMustacheTheme < ActiveRecord::Migration
  def self.up
    create_table(:mustache_themes) do |t|
      t.string :type
      t.string :name
      t.text   :description
      t.text   :html
      t.text   :css
      t.timestamps
    end

    add_index :mustache_themes, :type

    create_table(:mustache_theme_images) do |t|
      t.string :type
      t.string :image
      t.timestamps
    end
    add_index :mustache_theme_images, :type

  end

  def self.down
    drop_table :mustcache_themes
    drop_table :mustcache_theme_images
  end
end
