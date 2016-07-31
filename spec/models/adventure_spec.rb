require "rails_helper"

describe Adventure, type: :model do

  it { should validate_presence_of(:title) }

  it { should validate_uniqueness_of(:title) }

  it { should validate_presence_of(:image) }

  it { should validate_presence_of(:synopsis) }

  scenario "adventure can be created" do
    expect{create( :adventure, title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + 'app/assets/images/Bristol.jpeg', 'image/jpeg') )}.to change{Adventure.count}.by(1)
  end

  scenario "non image type files cannot be added" do
    adventure = 'app/controllers/concerns/.keep'
    adventure_rb = 'app/controllers/adventures_controller.rb'
    adventure_html_erb = 'app/views/adventures/index.html.erb'
    adventure_md = 'README.md'

    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_rb}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_html_erb}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure_md}", 'image/jpeg'))).to have(1).error_on(:image)
    expect(Adventure.new(title: "Hello", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{adventure}", 'image/jpeg'))).to have(1).error_on(:image)
  end

  scenario "type of image files accepted" do
    jpeg = 'app/assets/images/Bristol.jpeg'
    png = 'app/assets/images/png.png'
    svg = 'app/assets/images/svg.svg'
    gif = 'app/assets/images/giphy.gif'

    expect{create( :adventure, title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{jpeg}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "png", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{png}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "svg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{svg}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
    expect{create( :adventure, title: "gif", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + "#{gif}", 'image/jpeg') )}.to change{Adventure.count}.by(1)
  end
end
