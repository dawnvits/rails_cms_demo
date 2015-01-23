class Page < ActiveRecord::Base

  belongs_to :subject
  has_many :sections

  acts_as_list :scope => :subject
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink
  # use ":scope => :subject_id" for unique values by subject

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
  scope :sorted, lambda { order("pages.position ASC") }
  scope :newest_first, lambda { order("pages.created_at DESC")}

end
