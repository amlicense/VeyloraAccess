class Organization < ApplicationRecord
  has_many :memberships, dependent: :restrict_with_exception
  has_many :users, through: :memberships
  has_many :employees, dependent: :restrict_with_exception
  has_many :groups, dependent: :restrict_with_exception
  has_many :devices, dependent: :restrict_with_exception
  has_many :policies, dependent: :restrict_with_exception
  validates :name, :slug, presence: true
  validates :slug, uniqueness: true
  normalizes :slug, with: ->(value) { value.strip.downcase }
end
