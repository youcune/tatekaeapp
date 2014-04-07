#coding: utf-8
class Mail
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :to, :cc, :bcc, :subject, :content
  
  validates :to, 
    format: {with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i ,
              message: "%{value}は有効なメールアドレスではありません", unless: "to.nil?"}
  validates :cc, 
    format: {with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i ,
              message: "%{value}は有効なメールアドレスではありません", unless: "cc.nil?"}
  validates :bcc, 
    format: {with: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i ,
              message: "%{value}は有効なメールアドレスではありません", unless: "bcc.nil?"}

  validates :subject, presence:{message: "件名を入力してください"}
  validates :content, presence:{message: "本文を入力してください"}
  validates :content, length:{maximum: 10,message: "本文は%{count}文字以内で入力してください"}
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end

