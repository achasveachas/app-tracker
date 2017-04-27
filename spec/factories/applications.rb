FactoryGirl.define do
  factory :application do
    user
    company Faker::Company.name
    contact_name Faker::Name.name
    contact_title Faker::Job.title
    date Faker::Date.forward
    action "Meeting"
    first_contact false
    job_title Faker::Job.title
    job_url Faker::Internet.url
    notes Faker::Hipster.paragraph
    complete false
    next_step "Get Job"
    status nil
  end
end
