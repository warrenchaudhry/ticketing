FactoryGirl.define do
  factory :ticket do
    title "MyString"
    description "MyText"
    status 1
    reporter_id 1
    assigned_to 1
    assigned_by 1
    started_at "2016-09-14 11:53:28"
    resolved_at "2016-09-14 11:53:28"
    status 0
    priority 0
  end
end
