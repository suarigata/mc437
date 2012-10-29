class AddLogadoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :logado, :boolean
  end
end
