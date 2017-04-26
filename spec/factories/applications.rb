FactoryGirl.define do
  factory :application do
    user
    company "SpaceX"
    contact_name "Elon Musk"
    contact_title "Founder"
    date "12/30"
    action "Meeting"
    first_contact false
    job_title "Developer"
    job_url "www.spacex.com"
    notes nil
    complete false
    next_step "Get Job"
    status nil
  end
end
