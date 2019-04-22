class AddAttachmentAvatarToPlays < ActiveRecord::Migration[5.2]
  def self.up
    change_table :plays do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :plays, :avatar
  end
end
