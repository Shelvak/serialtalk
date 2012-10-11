class Package
  @@current_sequence = rand(0x20..0x7f)

  def initialize(*data)
    @data = data
  end

  def to_a
    bundle
  end

  def to_s
    to_a.map { |b| '%02x' % b }.join(' ')
  end

  def self.next_sequence
    @@current_sequence = @@current_sequence > 0x7e ?
      0x20 : @@current_sequence + 1
  end

  protected

  def concat_data(*data)
    @data.concat [*data]
  end

  def concat_with_separator(*data)
    concat_data [0x1c, *data].flatten
  end

  def options_for_client(options ||= {})
    [
      options[:buyer_iva_charge] || 'F',
      options[:name][0..39], options[:name][40..79], 
      options[:ui_type], options[:ui_number], 'N',
      options[:address][0..39], options[:address][40..79], 
      options[:address][80..119], '', ''
    ]
  end

  private

  def bundle
    @_bundle ||= concat_checksum [
      0x02, self.class.next_sequence, @data, 0x03
    ].flatten
  end

  def concat_checksum(data)
    hex_sum = '%04x' % data.inject(0) { |t, b| t + b }

    data.concat [*hex_sum.upcase.bytes]
  end
end

Dir.glob(File.join('packages', '*.rb')) do |l|
  require "./#{l}"
end

# Example

puts NuevoTicketFactura.new(
  name: 'Pepe Ongo', ui_type: 'DNI', ui_number: '38123321128',
  address: 'White House s/n'
)
