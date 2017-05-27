FactoryGirl.define do
  10.times do |time|
    factory "user#{time}".to_sym, class: User do
      email "user#{time}@example.com"
      password_digest BCrypt::Password.create('secret')
      admin false
    end
  end
  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    email "admi3n@example.com"
    password_digest BCrypt::Password.create('secret')
    admin true
  end
end