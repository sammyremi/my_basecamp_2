class Document < ApplicationRecord
  attribute :filename, :string
  attribute :content_type, :string  # Add this line
  belongs_to :project
  has_many_attached :attachments
  
  def image?
    content_type.start_with?('image/png', 'image/jpg', 'image/jpeg') if content_type.present?
  end
  def text?
    content_type == 'text/plain' || content_type == 'application/pdf' if content_type.present?
  end
  def content_type
    attachments.first.blob.content_type if attachments.attached?
  end
  def url
    attachments.first&.url(expires_in: 1.hour)
  end
  def text_content
    if content_type == 'text/plain'
      read_text_file
    elsif content_type == 'application/pdf'
      read_pdf_file
    else
      'Unsupported file type'
    end
  end
  private
  def read_text_file
    attachments.map { |attachment| File.read(attachment.blob.service.send(:path_for, attachment.blob.key)) }.join("\n")
  end

end
