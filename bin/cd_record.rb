puts "Ingrese el directorio a grabar"
STDOUT.flush
dir = gets.chomp
puts "Velocidad de Grabacion[16]"
STDOUT.flush
speed = gets.chomp
speed = speed.empty? ? 16 : speed
APP_DIR = "~/.cd_record/"
ISO = "image.iso"
  `mkdir #{APP_DIR}`
system "mkisofs -R -J -T -o #{APP_DIR + ISO} #{dir}"

bus = `cdrecord --scanbus`
dev = '0,0,0'
bus.split("\n").each do |line|
    dev = line.split(" ")[0] unless line=~ /\*|:\z/
end
`cdrecord -v speed=#{speed} dev=#{dev} -data #{APP_DIR + ISO}`
system "rm #{APP_DIR + ISO}"

