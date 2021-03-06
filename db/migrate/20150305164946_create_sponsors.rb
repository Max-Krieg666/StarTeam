class CreateSponsors < ActiveRecord::Migration[5.1]
  def change
    create_table :sponsors, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.string :title, null: false, limit: 30
      t.integer :specialization, null: false
      t.references :team, type: :uuid
      t.decimal :loyalty_factor, default: 1.0, precision: 3, scale: 2, null: false
      t.decimal :cost_of_full_stake, precision: 20, scale: 2, null: false
      t.decimal :win_prize, precision: 7, scale: 2, null: false
      t.decimal :draw_prize, precision: 7, scale: 2, null: false
      t.decimal :lost_prize, precision: 7, scale: 2, null: false

      t.timestamps null: false
    end
  end
end
