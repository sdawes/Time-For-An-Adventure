require "rails_helper"

feature "Delete chapters" do
  scenario "it deletes children chapters" do
    choice1   = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)
    choice3   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter3  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice3.id)

    p "chapter1: #{chapter1.id}"
        p "chapter2: #{chapter2.id}"
            p "chapter3: #{chapter3.id}"
    chapter1.children_chapters(chapter1)
  end
end
