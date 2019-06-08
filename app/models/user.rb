# frozen_string_literal: true
require 'elasticsearch/model'

class User < ApplicationRecord
  attr_writer :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:login]
  has_many :maps
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :username]
    )
  end 

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h)
        .where(['lower(username) = :value OR lower(email) = :value',
                { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_h).first
    end
  end

  settings analysis: {
    filter: {
      trigrams_filter: {
        type: 'ngram', min_gram: 3, max_gram: 3
      }
    },
    analyzer: {
      trigrams: {
        type: 'custom', tokenizer: 'standard', filter: ['lowercase', 'trigrams_filter']
      }
    }
  } do
    mapping do
      indexes :username
    end
  end
end
User.__elasticsearch__.create_index! force: true
User.import
