require 'digest'

class MessagesController < ApplicationController
  def root
    sha256 = Digest::SHA256.new
    @digest = sha256.hexdigest "foo"
    render json: @digest
  end

  def create
    sha256 = Digest::SHA256.new
    message = params["message"]
    @digest = sha256.hexdigest message

    @message = Message.new(:content => message, :digest => @digest)
    @message.save

    @data = { "digest" => @digest }
    render json: @data
  end

  def digest
    @message = Message.find_by(digest: params[:digest])


    if @message
      @data = { "message" => @message.content }
      render json: @data
    else
      render json: "No such hash exists!", status: 404
    end
  end
end
