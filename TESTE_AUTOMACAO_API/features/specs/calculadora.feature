#language:pt
@start_calculadora
Funcionalidade: Operações Basicas Calculadora API SOAP
    Possuindo o valor A e B
    Uma requisição será realizada na API
    afim de realizar uma função especificas de uma calculadora

Cenário: Somar Dois Numeros Randômicos
  Quando realizar uma requisição para somar dois numeros
  Então a API irá retornar o status a resposta da operação de somar

Cenário: Subtrair Dois Numeros Randômicos
  Quando realizar uma requisição para subtrair dois numeros
  Então a API irá retornar o status a resposta da operação de subtrair

Cenário: Dividir Dois Numeros Randômicos
  Quando realizar uma requisição para dividir dois numeros
  Então a API irá retornar o status a resposta da operação de dividir

Cenário: Multiplicar Dois Numeros Randômicos
  Quando realizar uma requisição para multiplicar dois numeros
  Então a API irá retornar o status a resposta da operação de multiplicar
