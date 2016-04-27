class Document < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true

  belongs_to :user
  belongs_to :folder
end
