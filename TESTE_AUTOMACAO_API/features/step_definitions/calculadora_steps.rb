Quando('realizar uma requisição para somar dois numeros') do
    @funcao_calc.operacoesCalc('somar')
end

Então('a API irá retornar o status a resposta da operação de somar') do
    @response = @funcao_calc.validarDados
    expect(@response[:resposta]).to eql("#{@soma}")
end

Quando('realizar uma requisição para subtrair dois numeros') do
    @funcao_calc.operacoesCalc('subtrair')
end

Então('a API irá retornar o status a resposta da operação de subtrair') do
    @response = @funcao_calc.validarDados
    expect(@response[:resposta]).to eql("#{@subtrai}")
end

Quando('realizar uma requisição para dividir dois numeros') do
    @funcao_calc.operacoesCalc('dividir')
end

Então('a API irá retornar o status a resposta da operação de dividir') do
    @response = @funcao_calc.validarDados
    expect(@response[:resposta]).to eql("#{@dividi}")
end

Quando('realizar uma requisição para multiplicar dois numeros') do
    @funcao_calc.operacoesCalc('multiplicar')
end

Então('a API irá retornar o status a resposta da operação de multiplicar') do
    @response = @funcao_calc.validarDados
    expect(@response[:resposta]).to eql("#{@multiplica}")
end
