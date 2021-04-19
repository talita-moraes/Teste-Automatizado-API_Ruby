class FuncoesCalculadora
    @@cabecalho = ''

    def initialize(body, url)
      @options = { body: body, url: url }
    end
  
    def operacoesCalc(operacao)
      case operacao
      when /somar/
        @@cabecalho = 'add'
      when /subtrair/
        @@cabecalho = 'subtract'
      when /dividir/
        @@cabecalho = 'divide'
      when /multiplicar/
        @@cabecalho = 'multiply'
      end

      @@cabecalho_s = @@cabecalho.to_sym
      client = Savon.client( wsdl: @options[:url] ) 
      @response = client.call(
        @@cabecalho_s, message: {
          int_a: @options[:body]['int_a'],
          int_b: @options[:body]['int_b'],
        }
      )
    end

    def modelo
      client = Savon.client( wsdl: @options[:url] ) 
      @response = client.call(
        @@cabecalho_s, 'message' => @options[:body]
      )
    end

    def alterar_valor(campo,valor)
      @options[:body][campo] = valor
    end
  
    def validarDados
      @hash_reponse = (@@cabecalho + '_response').to_sym
      @hash_result = (@@cabecalho + '_result').to_sym
      @resp = @response.body[@hash_reponse][@hash_result]
      @resp_msg = @resp.split(/[,:{}"\[\]]/)
      @resp_msg = @resp_msg.reject(&:empty?)
  
      @metodos = Metodos.new
      @@valores = {}
      @@valores[:resposta] = @resp_msg[0]
      @@valores
    end
  end
  