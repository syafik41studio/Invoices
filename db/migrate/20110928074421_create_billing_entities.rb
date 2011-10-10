class CreateBillingEntities < ActiveRecord::Migration
  def self.up
    create_table :billing_entities do |t|
      t.string :name
      t.string :branch
      t.string :entity_type
      t.boolean :active
      t.string :billing_format
      t.string :clearing_house
      t.string :departement
      t.string :attn
      t.string :address_line_1
      t.string :address_line_2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :fax
      t.string :other_info_1
      t.string :other_info_2
      t.string :other_info_3
      t.string :other_info_4
      t.text :comment
      t.integer :invoice_id
      t.string :insurance_plan
      t.boolean :mediacare
      t.boolean :mediacaid
      t.boolean :tricare
      t.boolean :champva
      t.boolean :healt_plan
      t.boolean :black_ling
      t.boolean :other
      t.boolean :accept_assignment
      t.timestamps
    end
  end

  def self.down
    drop_table :billing_entities
  end
end
