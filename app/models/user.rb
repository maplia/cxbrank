class User < ActiveRecord::Base
  def self.authenticate(id, password)
    return self.find_by_id_and_password(id.to_i, Digest::SHA1.hexdigest(password))
  end
end
