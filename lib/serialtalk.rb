require 'serialport'
require 'trollop'

options = Trollop::options do
  version "RubySerie (c) #{Time.now.year} Nestor Coppi"
  banner <<-EOS
SerialTalk, serial communication to print in fiscal printers

Usage:
       serialtalk [options]

where [options] are:
EOS
  
  opt :port, 'name of the device', default: '/dev/ttyS0'
  opt :baudrate, 'from 50 to 1000000, depends on platform', default: 19200
  opt :databits, 'from 5 to 8 (4 is allowed on Windows)', default: 8
  opt :stopbits, '1 or 2 (1.5 is not supported)', default: 1
  opt :parity, 'SerialPort::(NONE||EVEN||ODD)', default: SerialPort::NONE
end

SerialPort.open(options.delete(:port), options) do |port|
  port << [0x02]
end
