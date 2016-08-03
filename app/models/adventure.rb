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
    html += "<li><a href='/adventures/" + "#{chapter_node.adventure_id}" + "/chapters/#{chapter_node.id}/choices/new'> Chapter #{chapter_node.id}</a>"
    moreChoices?(chapter_node) ? html += "<ul>" : html += "</li>"
    if chapter_node.parent_choice_id != nil && !moreChoices?(chapter_node)
      html += "</ul>" if end_of_row?(chapter_node)
    end
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
    find_children_chapters(check_chapter, false) != []
  end

  def find_children_chapters(chapter, array_of_ids)
    @choices = Choice.where(chapter_id: chapter.id)
    find_chapters_from_choices(@choices, array_of_ids)
  end

  def find_chapters_from_choices(array_of_choices, array_of_ids)
    chapters = []
    if array_of_ids = false
      array_of_choices.each do |choice|
        chapters << Chapter.where(parent_choice_id: choice.id)
      end
    else
      array_of_choices.each do |choice|
        chapters << Chapter.where(parent_choice_id: choice.id).pluck(:id)
      end
    end
    chapters.flatten
  end

  def end_of_row?(chapter)
    choice_found = find_parent_choice(chapter)
    parent_chapter = find_parent_chapter(choice_found)
    if parent_chapter != nil
      children_chapter_ids = find_children_chapters(parent_chapter, true)
      highest_chapter_id(children_chapter_ids, chapter)
    else
      return false
    end
  end

  def highest_chapter_id(children_chapter_ids, current_chapter)
    children_chapter_ids.max === current_chapter.id
  end


  def find_parent_choice(chapter)
    Choice.find(chapter.parent_choice_id)
  end

  def find_parent_chapter(choice)
    return nil if choice.chapter_id.nil?
    Chapter.find(choice.chapter_id)
  end

end
