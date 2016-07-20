require 'sinatra'
require 'pry'
require 'exifr'

get '/' do
  pictures = Dir["public/uploads/*.jpg"].map do |path|
    { src: path.split('/')[1..-1].join('/'),
      metadata: EXIFR::JPEG.new(path)
    }
  end

  erb :index, locals: { pictures: pictures }
end

get '/upload' do
  File.read('upload.html')
end

post '/upload' do
  params[:pictures].each do |picture|
    pic = picture[:tempfile].read
    ext = picture[:filename].split('.').last.downcase
    file_name = "#{Digest::SHA1.hexdigest(pic)}.#{ext}"

    File.open("public/uploads/#{file_name}", 'w'){|f| f.write(pic)}
  end

  redirect to('/')
end
