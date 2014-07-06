class User < ActiveRecord::Base
	attr_accessor :password, :password_confirmation

	has_many :ideas
	has_many :likes, :dependent => :destroy
	email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :alias, presence: true, length: { maximum: 30 }
	validates :email, presence: true, format: { with: email_regex }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, confirmation: true, length: { minimum: 8 }

	#before the user gets added to the db, run this function
	before_save :encrypt_password

	#this method encrypts the user's login attempt and returns true if the password is a match
	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	#class method that checks whether the user's email and submitted password are valid
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	private
		def encrypt_password
			#generate a unique salt if it's a new user
			#self.password uses the attr_accessor defined above to enable the inputed password to be used
			self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{self.password}") if self.new_record?

			#encrypt the password and store that in the encrypted_password field
			self.encrypted_password = encrypt(self.password) #this self.password is from the post data
		end

		def encrypt(pass)
			Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
		end
end
