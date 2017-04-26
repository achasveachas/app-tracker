class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications do |t|
      t.belongs_to :user, foreign_key: true
      t.string :company
      t.string :contact_name
      t.string :contact_title
      t.string :date
      t.string :action
      t.boolean :first_contact
      t.string :job_title
      t.string :job_url
      t.text :notes
      t.boolean :complete, default: false
      t.string :next_step
      t.string :status

      t.timestamps
    end
  end
end
