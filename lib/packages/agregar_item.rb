class AgregarItem < Package
  def initialize(tipo_factura = 'B',options ||= {})
    super(0x62)

    description = options[:description]

    price = ((tipo_factura == 'A' ? 
      options[:unit_price] / (1 + options[:iva] / 100) : 
      options[:unit_price]).to_f.round(2) * 100).to_i

    product_without_description = [
      options[:quantity].to_f * 1000,
      price, (options[:iva] * 100).to_i
      'M', 1, 0
    ]
    
    if description.length <= 18
      data = [
        description[0..17],
        product_without_description,
        '', '', '', ''
      ]
    elsif
      data = [
        description[18..35],
        product_without_description,
        description[0..17], '', '', ''
      ]
    elsif
      data = [
        description[36..53],
        product_without_description,
        description[0..17], description[18..35], '', ''
      ]
    end

    data = data.flatten
          
    concat_with_separator(*data.bytes)
  end 
end 
