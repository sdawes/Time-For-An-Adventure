class Adventure < ApplicationRecord

  has_many :chapters
  has_many :choices, through: :chapters

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :title, uniqueness: true, presence: true
  validates :synopsis, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def traverse_tree(chapter_node)
    html = ''
    html += "<ul>" if first_chapter(chapter_node)
    html += "<li><a href='#'>Chapter #{chapter_node.id}</a>"
    moreChoices?(chapter_node) ? html += "<1ul>" : html += "</li>"

    chapter_node.choices.each do |choice|
      next_chapter = Chapter.where(parent_choice_id: choice.id).first
      next_html = !!(next_chapter) ? traverse_tree(next_chapter) : "</ul></li>"
      html += next_html
    end
    html
  end

  def create_tree(chapter_node)
    return 'not available' if chapter_node.nil?
    html = traverse_tree(chapter_node)
    html += "</ul></li>" * calculate_uls(html)
    html += "</ul>"
  end

  def calculate_uls(html)
    (count_opening_uls(html) - 1) - count_closing_uls(html)
  end

  def count_opening_uls(html)
    html.scan(/<ul>/).size
  end

  def count_closing_uls(html)
    html.scan(/<\/ul>/).size
  end

  # return true if first chapter
  def first_chapter(chapter)
    chapter.id === self.chapters.first.id
  end

  def last_chapter(chapter)
    chapter.id === self.chapters.last.id
  end

  # checks a chapter does not have resulting chapters
  def moreChoices?(check_chapter)
    p '==========='
    p self
    if (self.choices.each do |choice| return true if check_chapter.id === choice.chapter_id end) === true
      return true
    else
      p 'Hello World'
      return false
    end
  end

end

# html += "<li><a href='/adventures/" + "#{chapter_node.adventure_id}" + "/chapters/#{chapter_node.id}/choices/new'> Chapter #{chapter_node.id}</a>"
