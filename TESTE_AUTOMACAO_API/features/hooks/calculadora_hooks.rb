Before do
    @valor_a = Faker::Number.number(digits: 2)
    # puts "Valor a = #{@valor_a}"
    @valor_b = Faker::Number.number(digits: 2)
    # puts "Valor b = #{@valor_b}"

    @soma = @valor_b + @valor_a
    @subtrai = @valor_a - @valor_b
    @dividi = @valor_a / @valor_b
    @multiplica = @valor_b * @valor_a

    @body_somar = {
      'int_a' => @valor_a.to_i,
      'int_b' => @valor_b.to_i,
    }

    @funcao_calc = FuncoesCalculadora.new(@body_somar, CONFIG['url'])
end

