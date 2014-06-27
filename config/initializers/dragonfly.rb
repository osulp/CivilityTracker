Dragonfly.app.configure do
  generator :qr do |content, *args|
    content.ext = "png"
    content.update RQRCode::QRCode.new(args.first, :size => 8).to_img.resize(180,180).to_string
  end
end
