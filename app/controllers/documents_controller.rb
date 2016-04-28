class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def create
    @folder = current_user.folders.find(params[:folder_id]) if params[:folder_id].present?
    
    @document = if @folder.present?
      @folder.documents.new(document_params)
    else
      current_user.documents.new(document_params)
    end

    path = if @folder.present?
      folder_path(@folder)
    else
      folders_path
    end

    respond_to do |format|
      if @document.save
        format.html { redirect_to path, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to folders_path, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    url = Document.find(params[:id]).attachment.try(:url)

    destination_file_full_path = Rails.root.to_s + "/" + url.to_s.split("/").last
    begin
      open(destination_file_full_path, 'wb') do |file|
        file << open(url).read
      end
    rescue
      puts "Exception occured while downloading..."
    end
    redirect_to :back
    # destination_file_full_path
    # @dbsession = DropboxSession.new(Rails.application.secrets[:dropbox]['app_key'], Rails.application.secrets[:dropbox]['app_secret'])
    # redirect_to DropboxClient.new(@dbsession, Rails.application.secrets[:dropbox]['mode']).shares(url)
  end

  def edit
  end

  def index
    @documents = current_user.documents
  end

  def new
    @document = if params[:folder_id]
      current_user.folders.find(params[:folder_id]).documents.new
    else
      current_user.documents.new
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def document_params
      params.fetch(:document, {}).permit!
    end

    def set_document
      @document = current_user.documents.find(params[:id])
    end
end
