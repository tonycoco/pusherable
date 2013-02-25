ActiveRecord::Schema.define do
  self.verbose = false

  create_table :non_pusherable_models, :force => true do |t|
    t.timestamps
  end

  create_table :defaulted_pusherable_models, :force => true do |t|
    t.timestamps
  end

  create_table :pusherable_models, :force => true do |t|
    t.timestamps
  end
end
