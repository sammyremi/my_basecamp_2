class DocumentsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    attachments = Array(params[:document][:attachments]) # Ensure attachments is an array
    attachments.each do |attachment|
      next if attachment.blank? # Skip empty attachments
      @document = Document.new(document_params)
      @document.attachments.attach(attachment)
      @document.filename = attachment.original_filename if attachment.respond_to?(:original_filename)
      @document.content_type = attachment.content_type.to_s if attachment.respond_to?(:content_type)
      @document.save
    end
    if @document.persisted?
      redirect_to @project, notice: 'Attachment was successfully created.'
    else
      redirect_to @project, alert: 'Failed to create attachment.'
    end
  end
  def show
    @document = Document.find(params[:id])
    ActiveStorage::Current.url_options = {
host: request.base_url,
protocol: request.protocol
}
  end
def destroy
    @document = Document.find(params[:id])
    @project = @document.project
    if @document.destroy
      redirect_to @project, notice: 'Attachment was successfully deleted.'
    else
      redirect_to @project, alert: 'Failed to delete attachment.'
    end
end
private
def document_params
    params.permit(:filename, :content_type, :project_id, documents: [])
  end
end




