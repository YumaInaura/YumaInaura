class ExampleValidator < ActiveModel::Validator
  def validate(record)
    items = [record.name, record.age]
    return if items.any?(&:present?)
    record.errors.add(:base, "どれか1つの項目は入力してください。")
  end
end


class Example < ApplicationRecord
  include ActiveModel::Validations
  validates_with ExampleValidator
end
