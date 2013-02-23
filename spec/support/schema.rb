ActiveRecord::Schema.define do
  self.verbose = false

  create_table :pusherable_models, :force => true do |t|
    t.timestamps
  end
end
