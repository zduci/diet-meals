class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :meals

  has_many :stars

  def name
    email.slice(/[^@]*/)
  end

  ANONYMOUS = Class.new do
    def self.name
      "anonymous"
    end
  end
end
