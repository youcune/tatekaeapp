#encoding: utf-8
class Form < ActiveRecord::Base
  attr_accessible :email, :event_id, :name, :str_id
  belongs_to :event
  validates :name, presence: {message: "お名前を入力してください"}
  validates :email, presence: {message: "メールアドレスを入力してください"}
end
