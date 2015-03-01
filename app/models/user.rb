class User < ActiveRecord::Base
  def self.authenticate(id, password)
    return self.where('id = ? and password = ?', id.to_i, Digest::SHA1.hexdigest(password)).first
  end
end
