class AdminUser < ApplicationRecord

	has_secure_password
	has_and_belongs_to_many :pages
	
	has_many :section_edits
	has_many :sections, :through => :section_edits

	scope :sorted, lambda { order("last_name ASC, first_name ASC")}

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i

	validates_presence_of :first_name
	validates_length_of :first_name, :within => 2..25
	validates_presence_of :last_name
	validates_length_of :last_name, :within => 2..25
	validates_presence_of :username
	validates_length_of :username, :within => 8..25
	validates_uniqueness_of :username
	validates_presence_of :email
	validates_length_of :email, :maximum => 100
	validates_format_of :email, :with => EMAIL_REGEX
	validates_confirmation_of :email
	validates_presence_of :password
	validates_length_of :password, :within => 6..25
	validates_confirmation_of :password

	attr_accessor :password_confirmation


	def name
		"#{first_name} #{last_name}"
	end
end
