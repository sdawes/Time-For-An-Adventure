require "spec_helper"

describe Adventure, type: :model do
  it "needs every adventure to have a unique title" do
    Adventure.create(title: "Hello")
    new_adventure = Adventure.new(title: "Hello")
    expect(new_adventure).to have(1).error_on(:title)
    expect(new_adventure).not_to be_valid
  end
end
