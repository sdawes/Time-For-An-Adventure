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

  scenario "adventure#create_tree can create a nested list for one chapter" do
    choice    = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter   = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter.id}</a></li></ul>"
  end

  scenario "adventure#create_tree can create a nested list with one parent and one child" do
    choice1    = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)


    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter1.id}</a><ul><li><a href='#'>Chapter #{chapter2.id}</a></li></ul></li></ul>"
  end

  scenario "adventure#create_tree can create a nested list with one head and two chapters" do
    choice1   = Choice.create(option: '')
    adventure = Adventure.create( title: "jpeg", synopsis: "once upon a time", image: Rack::Test::UploadedFile.new(Rails.root + jpeg = 'app/assets/images/Bristol.jpeg', 'image/jpeg'))
    chapter1  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice1.id)
    choice2   = Choice.create(option: 'choice 1', chapter_id: chapter1.id)
    chapter2  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice2.id)
    choice3   = Choice.create(option: 'choice 1', chapter_id: chapter2.id)
    chapter3  = Chapter.create(description: 'hello world', adventure_id: adventure.id, parent_choice_id: choice3.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter1.id}</a><ul><li><a href='#'>Chapter #{chapter2.id}</a></li><li><a href='#'>Chapter #{chapter3.id}</a></li></ul></li></ul>"
  end

  xscenario "adventure#tree can create a nested list with one head and three chapters" do
    adventure  = Adventure.create(title: 'Stanger Things', synopsis: 'Once upon a time...')
    chapter1   = Chapter.create(description: 'hello 1', adventure_id: adventure.id)
    chapter2   = Chapter.create(description: 'hello 2', adventure_id: adventure.id)
    chapter3   = Chapter.create(description: 'hello 3', adventure_id: adventure.id)
    chapter4   = Chapter.create(description: 'hello 4', adventure_id: adventure.id)

    choicea1    = Choice.create(option: 'choice 1', chapter_id: chapter1.id, resulting_chapter_id: chapter2.id)
    choicea2    = Choice.create(option: 'choice 2', chapter_id: chapter1.id, resulting_chapter_id: chapter3.id)
    choicea3    = Choice.create(option: 'choice 3', chapter_id: chapter1.id, resulting_chapter_id: chapter4.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter1.id}</a><ul><li><a href='#'>Chapter #{chapter2.id}</a></li><li><a href='#'>Chapter #{chapter3.id}</a></li><li><a href='#'>Chapter #{chapter4.id}</a></li></ul></li></ul>"
  end

  xscenario "adventure#tree can create a nested list with one parent and two children, each with 6 grandchildren" do
    adventure  = Adventure.create(title: 'Stanger Things', synopsis: 'Once upon a time...')
    chapter1   = Chapter.create(description: 'hello 1', adventure_id: adventure.id)
    chapter2   = Chapter.create(description: 'hello 2', adventure_id: adventure.id)
    chapter3   = Chapter.create(description: 'hello 3', adventure_id: adventure.id)
    chapter4   = Chapter.create(description: 'hello 4', adventure_id: adventure.id)
    chapter5   = Chapter.create(description: 'hello 5', adventure_id: adventure.id)

    choicea1    = Choice.create(option: 'choice 1', chapter_id: chapter1.id, resulting_chapter_id: chapter2.id)
    choicea2    = Choice.create(option: 'choice 2', chapter_id: chapter2.id, resulting_chapter_id: chapter3.id)
    choicea3    = Choice.create(option: 'choice 3', chapter_id: chapter2.id, resulting_chapter_id: chapter4.id)
    choicea4    = Choice.create(option: 'choice 3', chapter_id: chapter2.id, resulting_chapter_id: chapter5.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter1.id}</a><ul><li><a href='#'>Chapter #{chapter2.id}</a><ul><li><a href='#'>Chapter #{chapter3.id}</a></li><li><a href='#'>Chapter #{chapter4.id}</a></li><li><a href='#'>Chapter #{chapter5.id}</a></li></ul></li></ul></li></ul>"
  end

  xscenario "adventure#tree can create a nested list with one parent and two children, each with 6 grandchildren" do
    adventure  = Adventure.create(title: 'Stanger Things', synopsis: 'Once upon a time...')
    chapter1   = Chapter.create(description: 'hello 1', adventure_id: adventure.id)
    chapter2   = Chapter.create(description: 'hello 2', adventure_id: adventure.id)
    chapter3   = Chapter.create(description: 'hello 3', adventure_id: adventure.id)
    chapter4   = Chapter.create(description: 'hello 4', adventure_id: adventure.id)
    chapter5   = Chapter.create(description: 'hello 5', adventure_id: adventure.id)
    chapter6   = Chapter.create(description: 'hello 6', adventure_id: adventure.id)
    chapter7   = Chapter.create(description: 'hello 7', adventure_id: adventure.id)
    chapter8   = Chapter.create(description: 'hello 8', adventure_id: adventure.id)
    chapter9   = Chapter.create(description: 'hello 9', adventure_id: adventure.id)


    choicea1    = Choice.create(option: 'choice 1', chapter_id: chapter1.id, resulting_chapter_id: chapter2.id)
    choicea2    = Choice.create(option: 'choice 2', chapter_id: chapter1.id, resulting_chapter_id: chapter3.id)
    choicea3    = Choice.create(option: 'choice 3', chapter_id: chapter2.id, resulting_chapter_id: chapter4.id)
    choicea1    = Choice.create(option: 'choice 1', chapter_id: chapter2.id, resulting_chapter_id: chapter5.id)
    choicea2    = Choice.create(option: 'choice 2', chapter_id: chapter2.id, resulting_chapter_id: chapter6.id)
    choicea3    = Choice.create(option: 'choice 3', chapter_id: chapter3.id, resulting_chapter_id: chapter7.id)
    choicea1    = Choice.create(option: 'choice 1', chapter_id: chapter3.id, resulting_chapter_id: chapter8.id)
    choicea2    = Choice.create(option: 'choice 2', chapter_id: chapter3.id, resulting_chapter_id: chapter9.id)

    expect(adventure.create_tree(adventure.chapters.first)).to eq "<ul><li><a href='#'>Chapter #{chapter1.id}</a><ul><li><a href='#'>Chapter #{chapter2.id}</a><ul><li><a href='#'>Chapter #{chapter3.id}</a></li><li><a href='#'>Chapter #{chapter4.id}</a></li><li><a href='#'>Chapter #{chapter5.id}</a></li></ul></li><li><a href='#'>Chapter #{chapter6.id}</a><ul><li><a href='#'>Chapter #{chapter7.id}</a></li><li><a href='#'>Chapter #{chapter8.id}</a></li><li><a href='#'>Chapter #{chapter9.id}</a></li></ul></li></ul></li></ul>"
  end
end
