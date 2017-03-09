class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end

    create_table :services do |t|
      t.string :service
      t.float :price
      t.integer :duration
      t.boolean :disabled
      t.integer :company_id

      t.timestamps null: false
    end

    create_table :companies_services do |t|
      t.belongs_to :company, index: true
      t.belongs_to :service, index: true
    end
  end
end
