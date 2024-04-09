defmodule Prova do
  def log(x, e, k \\ 0, acc \\ 0, parte_constante \\ nil, parte_constante_quadrado \\ nil)

  def log(x, e, k, acc, nil, nil) do
    log(
      Decimal.new(x),
      Decimal.new(1, e, -35),
      Decimal.new(k),
      Decimal.new(acc),
      Decimal.from_float((x - 1) / (x + 1)),
      Decimal.mult(Decimal.from_float((x - 1) / (x + 1)), Decimal.from_float((x - 1) / (x + 1)))
    )
  end

  def log(x, e, k, acc, parte_constante, parte_constante_quadrado) do
    # 1/(2k+1)
    parte_dependente = Decimal.div(1, Decimal.add(Decimal.mult(2, k), 1))
    res = Decimal.mult(parte_dependente, parte_constante)

    if Decimal.compare(res, e) == :lt do
      IO.puts(Decimal.mult(Decimal.add(res, acc), 2))
    else
      log(
        x,
        e,
        Decimal.add(k, 1),
        Decimal.add(acc, res),
        Decimal.mult(parte_constante, parte_constante_quadrado),
        parte_constante_quadrado
      )
    end
  end
end
