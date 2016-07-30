require "spec_helper"

describe Adventure, type: :model do

  it { should validate_presence_of(:title) }

  it { should validate_uniqueness_of(:title) }

  it { should validate_presence_of(:synopsis) }

  scenario "adventure can be created" do
    expect{create( :adventure, title: "Hello", synopsis: "once upon a time" )}.to change{Adventure.count}.by(1)
  end
end
