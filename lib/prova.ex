defmodule Prova do
  # a variavel parte_constante será o parcela do somátorio que é apenas incrementada a sua potência
  def log(x, e, k \\ 0, acc \\ 0, parte_constante \\ nil)

  def log(x, e, k, acc, nil) do
    # Iniciando o codigo com precisao 100
    Decimal.Context.set(%Decimal.Context{
      flags: [],
      precision: 100,
      rounding: :half_up,
      traps: [:invalid_operation, :division_by_zero]
    })
    #

    # Iniciando valores que se adequem a biblioteca Decimal
    log(
      Decimal.new(x),
      Decimal.new(1, e, -35),
      k,
      Decimal.new(acc),
      Decimal.from_float((x - 1) / (x + 1))# x-1/x+1
    )
    #
  end

  def log(x, e, k, acc, parte_constante) do
    # a variável res é uma iteração particular do somatório
    res =
      Decimal.div(1, Decimal.add(Decimal.mult(2, k), 1)) # 1/(2k+1)
      |> Decimal.mult(pow(parte_constante, 2 * k + 1))

    # Caso de parada onde ocorre o ultimo incremento do acumulador acc, e uma vez terminado o somatório, a multiplicação por 2
    if Decimal.compare(res, e) == :lt do
      IO.puts(Decimal.mult(Decimal.add(res, acc), 2))
    else
      # Caso recursivo onde há incremento de k + 1 para a próxima iteração do somatório, acc para acumular o valor do somátorio
      # somando o resultado particular desta iteração
      log(
        x,
        e,
        k + 1,
        Decimal.add(acc, res),
        parte_constante
      )
    end
  end

  #Função auxiliar para uso de potências
  def pow(num, exp) do
    pow(num, exp, num)
  end

  def pow(_num, 1, acc) do
    acc
  end

  def pow(num, exp, acc) do
    pow(num, exp - 1, Decimal.mult(num, acc))
  end
end

