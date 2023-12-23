class CreateApplicants < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string "auth0_id", default: "temporary", null: false

      t.timestamps
    end
  end
end
