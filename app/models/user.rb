class User < ActiveRecord::Base
  validates :username, presence: {message: 'ユーザー名が入力されていません'}
  validates :password,
    presence: {message: 'パスワードが入力されていません'},
    confirmation: {message: '確認用パスワードが入力されていません'}
  validates :cxbid,
    length: {is: 8, message: 'CROSS×BEATS IDは8文字で入力してください'},
    format: {with: /\A\d+\z/, message: 'CROSS×BEATS IDは数字のみで入力してください'}, allow_blank: true

  def self.authenticate(id, password)
    return self.where('id = ? and password = ?', id.to_i, Digest::SHA1.hexdigest(password)).first
  end
end
