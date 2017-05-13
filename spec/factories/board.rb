FactoryGirl.define do

  factory :active, class: Board do
    title 'Admin Board'
    archived false
  end

  factory :archived, class: Board do
    title 'User Board'
    archived true
  end
end

