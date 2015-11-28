class FileDownloadController < ApplicationController
  def download
    file = DataFile.where(params[:data_file_id])
    result = {
      if file != nil
        retFile = file.path.url
    }
    render json: result
  end

  def upload
    file = DataFile.new( name: params[:name], space_id: params[:space_id] )
    file.pash = params[:path] + params[:current_dir]
    file.save!

    render json: "ok!"

  end
end
