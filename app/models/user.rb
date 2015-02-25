class User < ActiveRecord::Base
  def self.authenticate(id, password)
    return self.where(id.to_i, :password => Digest::SHA1.hexdigest(password)).first
  end
end
