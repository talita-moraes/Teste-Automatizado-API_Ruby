require 'dbi'
# Connection
class Connection
  def initialize
    @user = CONFIG['user_data']
    @pass = CONFIG['pass_data']
    @data = CONFIG['database']

    @dbh = DBI.connect("dbi:OCI8:#{@data}", @user, @pass)
  end

  # Método para realizar o select e retornar o resultado, recebe a query como parametro. 
  # Caso o segundo for ativo retornará um vetor
  def querySelect(string, vetor = false)
    result = @dbh.prepare(string)
    result.execute
    if (vetor == true)
      i =0 
      @rs = Array.new
      result.fetch do |row|
        @rs[i] = row.to_a.reverse.join
        i = i + 1
      end
    else
      result.fetch do |row|
        @rs = row[0]
      end
    end
    result.finish
    @rs
  rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts e.message
    puts "Error code:    #{e.err}"
    puts "Error message: #{e.errstr}"
  ensure
    @dbh.disconnect if @dbh
  end

  # Método para realizar um update, recebe a query e a informação que vai ser atualizado como parametro
  def queryUpdate(string, status)
    result = @dbh.prepare(string)
    result.execute(status)
    result.finish
    @dbh.commit
    # puts "Update para status #{status} executado com sucesso"
  rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts e.message
    puts "Error code:    #{e.err}"
    puts "Error message: #{e.errstr}"
    @dbh.rollback
  ensure
    @dbh.disconnect if @dbh
  end

  def queryInsert(nome_tabela, valores)
    # Concatenação dos campos a serem preenchidos na query
    valores.each_key  do |dados|
      @campos = "#{@campos},#{dados}"
    end

    # Concatenação dos values a serem preenchidos na query
    valores.each_value do |dados|
      @values = "#{@values},'#{dados}'"
    end

    # Removendo a 1º virgula, efeito da concatenação acima
    @values = @values[1.. @values.length]
    @campos = @campos[1.. @campos.length]

    @query = "INSERT INTO #{nome_tabela}(#{@campos}) VALUES(#{@values})"
    # puts @query

    @dbh.do(@query)
    @dbh.commit
    # puts "Record has been created"
  rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts "Error code:    #{e.err}"
    puts "Error message: #{e.errstr}"
    @dbh.rollback
  ensure
    @dbh.disconnect if @dbh
  end

  def queryDelete(query)
    result = @dbh.prepare(query)
    result.execute
    result.finish
    @dbh.commit
    # puts "Delete Realizado com Sucesso"
  rescue DBI::DatabaseError => e
    puts "An error occurred"
    puts "Error code:    #{e.err}"
    puts "Error message: #{e.errstr}"
    @dbh.rollback
  ensure
    @dbh.disconnect if @dbh
  end
end
