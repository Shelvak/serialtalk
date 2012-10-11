class NuevoTiqueFactura < Package
  def initialize(tipo_factura = 'B', options ||= {})
    super(0x60)
         
    data = [
      'T', 'C', tipo_factura.upcase, 1, 'P', 17, 
      options[:seller_iva_charge] || 'I', 
      options_for_client(options), 'C'
    ]

    concat_with_separator(*data.bytes)
  end
end
