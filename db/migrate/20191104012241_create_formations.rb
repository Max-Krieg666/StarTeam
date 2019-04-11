class CreateFormations < ActiveRecord::Migration[5.1]
  def change
    create_table :formations, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :name, unique: true
      t.string :schema
    end

    add_column :teams, :formation_id, :uuid, index: true
  end
end
