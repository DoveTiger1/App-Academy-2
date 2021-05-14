class ChangeTagTopics < ActiveRecord::Migration[5.2]
  def change
    change_column :tag_topics, :name, :string, null: false
  end
end
