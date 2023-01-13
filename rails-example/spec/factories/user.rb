
FactoryBot.define do
  factory :user do
    # name { "testuser" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
    # coment { "テスト" }
  end
end