class User < ActiveRecord::Base
  validates :username, presence: {message: 'ユーザー名が入力されていません'}
  validates :password,
    presence: {message: 'パスワードが入力されていません'},
    confirmation: {message: '確認用パスワードが入力されていません'}
  validates :cxb_id,
    length: {is: 8, message: 'CROSS×BEATS IDは8文字で入力してください'},
    format: {with: /\A\d+\z/, message: 'CROSS×BEATS IDは数字のみで入力してください'}, allow_blank: true

  before_save :crypt_password

  scope :current, ->(session) {find(session[:user_id].to_i)}
  scope :find_by_params, ->(params) {find(params[:id].to_i)}

  def self.authenticate(user_id, password)
    return self.find_by(id: user_id.to_i, password: Digest::SHA1.hexdigest(password))
  end

  def crypt_password
    if new_record? or changed.include?('password')
      self.password = Digest::SHA1.hexdigest(password)
      self.password_confirmation = Digest::SHA1.hexdigest(password_confirmation)
    end
  end
end
