# frozen_string_literal: true

class League < ApplicationRecord
  has_many :fixtures, dependent: :destroy
  has_many :leagues_teams, dependent: :destroy
  has_many :teams, through: :leagues_teams
  has_many :leagues_sponsors, dependent: :destroy
  has_many :sponsors, through: :leagues_sponsors
  has_many :seasons
  belongs_to :official, class_name: 'User', foreign_key: 'official_id'

  validates :title, uniqueness: { case_sensitive: false }

  scope :active, -> {  where(active: true).order(title: :asc) }
  scope :sponsors, -> {  sponsors.order(budget_amount: :asc) }

  def friendly?
    title.to_s.downcase.in? ['friendly', 'friendlies', 'club friendlies']
  end

  def self.all_paginated_leagues(per_page:, page:)
    limit(per_page).offset(page)
  end
end
