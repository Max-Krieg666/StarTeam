class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.references :team, type: :uuid
      t.boolean :kind
      t.string :title
      t.float :sum, null: false
      
      t.timestamps null: false
    end
  end
end
