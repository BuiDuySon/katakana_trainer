class User < ActiveRecord::Base

  has_many :questions

  devise :database_authenticatable, :omniauthable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable

  def m_word_ids
    self.questions.inject([]) do |words, question|
      words << question.m_word_ids
    end.flatten
  end

  class << self
    def find_for_facebook_oauth auth, signed_in_resource = nil
      user = User.where(provider: auth.provider, uid: auth.uid).first
      unless user
        user = User.create(name: auth.extra.raw_info.name,
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          password: Devise.friendly_token[0,20]
        )
      end
      user
    end

    def create_unique_string
      SecureRandom.uuid
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

  end
  def self.find_for_twitter_oauth auth, signed_in_resource = nil
    if user = User.where(provider: auth.provider, uid: auth.uid).first
      user
    else 
      user = User.create(name: auth.info.name,
                  provider: auth.provider, 
                  uid: auth.uid,
                  email: auth.uid + "@twitter.com",
                  password: Devise.friendly_token[0,20]
              )
    end
  end
end
