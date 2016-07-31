FactoryGirl.define do
  factory :adventure  do
    title "Makers"
    synopsis "Synopsis"
    image Rack::Test::UploadedFile.new(Rails.root + 'app/assets/images/Bristol.jpeg', 'image/jpeg')
  end
end
