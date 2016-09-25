class LoaderIoController < ApplicationController
  def verify
    render text: Figaro.env.loader_io_verify_token
  end
end
