class AddAttachmentAvatarToLeagues < ActiveRecord::Migration
  def self.up
    change_table :leagues do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :leagues, :avatar
  end
end
