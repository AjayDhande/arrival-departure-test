class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :flight_type
      t.string :date
      t.string :time
      t.string :expected_time
      t.string :from
      t.string :number
      t.string :airline_company
      t.string :gate
      t.string :status
      t.string :terminal
      t.string :link

      t.timestamps
    end
  end
end
