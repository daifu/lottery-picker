class CreateLotteryNumbersTable < ActiveRecord::Migration
  def change
    create_table :lottery_numbers do |t|
      t.integer :game_id
      t.string :numbers_string
      t.datetime :draw_date
      t.integer  :draw_id

      t.timestamps
    end

    add_index :lottery_numbers, :game_id
  end

  def down
    drop_table :lottery_numbers
  end
end
