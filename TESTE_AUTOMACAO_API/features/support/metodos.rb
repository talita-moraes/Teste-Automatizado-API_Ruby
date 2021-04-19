class Metodos 
  
    # Tratamento exclusivo para obter a mensagem de erro completa do response
    def mensagemErroResponse(response)
      @resp_erro = response.split(/[{}"\[\]]/)
      @resp_erro = @resp_erro.reject(&:empty?)
  
      @armazenar_msg = false
      for indece in 0..(@resp_erro.length) do
        @dado = @resp_erro[indece].to_s
        # identificando inicio e final da mensagem que desejamos
        if @dado == 'sMensagem'
          @armazenar_msg = true
        elsif @dado == 'sContexto'
          @armazenar_msg = false
          break
        end
  
        # Concatenando os dados para frase
        if @armazenar_msg == true
          mensagem = "#{mensagem}#{@dado} "
        end   
      end
      # puts mensagem
  
      # Removendo caracteres indesejados na mensagem obtida 
      if !mensagem.nil? && !mensagem.empty?
        mensagem = mensagem.chomp(" , ")
        mensagem = mensagem.chomp(" ")
        mensagem = mensagem.gsub('\r\n', ' ')
        mensagem = mensagem.gsub('sMensagem : ', '')      
      end
    end
  
    # Consulta via Banco
    def verificarOperacaoSelect(query, valorComparacao)
      @connection = Connection.new
      @result = @connection.querySelect(query)
      expect(@result).to eql(valorComparacao)
    end
  
    # Tratamento do response, caso o segundo for ativo retornará um vetor como todos os dados
    def retornaChaveResponse(resp, chave, multiplos_campo = false)
      # Obter todas as posições correspondente a chave especifica
      @indice = resp.each_index.select{|s| resp[s] == chave}
  
      # Ajuste do índice, incrementando +1 em cada posição encontrada no vetor anterior
      @indice = @indice.map{ |i| i + 1 }
      
      if multiplos_campo == true
        @dado_response = Array.new
        for e in 0..(@indice.size - 1) do
          # Pegando no response o dados de cada posição
          @dado_response[e] = resp[@indice[e].to_i]
        end
      else
        # Pegando no response o dado da 1º posição
        @dado_response = resp[@indice[0].to_i]
      end
      @dado_response
    end
  
    # ----------------------------------- METODOS UTILIZADOS PARA ANALISE DE RELATORIOS --------------------------------------------------------------
  
    # Comparação de entre dois vetores
    def verificarMulltiplosCampos(vetor_servico, valor_esperado)
      if (valor_esperado.class).to_s == 'String'
        # Retorna o indice do elemento no vetor, caso contrario retornará nil
        if vetor_servico.index(valor_esperado) == nil
          false
        else
          true
        end
  
      else
        # Retorna um novo array contendo elementos comuns aos dois arrays
        @valores_iguais = vetor_servico & valor_esperado
        @valores_iguais  == valor_esperado
      end
    end
  
    # Associando 2 vetor entre si para a criação de uma hash
    def criarHashComVetores(chave, valor, tipo = 'String')
        @hash = {}
        for e in 0..(chave.size - 1) do
          if(tipo == 'Inteiro')
            @hash[chave[e]] = valor[e].to_i + @hash[chave[e]].to_i
            # Removendo as casas decimais e convertendo para String
            @hash[chave[e]] = (@hash[chave[e]].to_s).chomp(".00")
          else
            @hash[chave[e]] = valor[e]
          end
        end
      @hash
    end
  
    # Compara duas hashes, analidando o valor e a chave
    def analisarHashes(hash_servico, hash_esperado)
      # Mapeando todas as chaves
      @chave_esperado = hash_esperado.keys
      @comparacao_nivel = true
  
      for e in 0..(@chave_esperado.size - 1) do
        # Nivel 1 - Verificar se a chave existe na hash do serviço
        @n1 = hash_servico.has_key?(@chave_esperado[e])
    
        # Nivel 2 - Verificar se a chave encontrada a cima possue o valor igual, sem considerar sinal
        @n2 = hash_servico[@chave_esperado[e]] == hash_esperado[@chave_esperado[e]]
        # puts " #{hash_servico[@chave_esperado[e]]} = #{hash_esperado[@chave_esperado[e]]}"
  
        @comparacao_nivel = @n1 & @n2 & @comparacao_nivel
      end
      @comparacao_nivel
    end
  end
  