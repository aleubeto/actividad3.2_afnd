defmodule Automata do

  #1: función determinize
  def setter([]), do: [[]]  #Caso base
  def setter([h|t]), do
    tail = setter(t)
    setter(h, tail, tail)
  end
  defp setter (_, [], acc), do: acc
  defp setter(y, [h|t], acc), do: setter(y, t, [[y|h] | acc])


  def determinize(n) do
    %{
      alpha: n.alpha,
      istates: [n.istates]
    }
  end
  #Ejecución: Automata.determinize(IniciandoTT.a1)

  def e_closure() do
    #2: función e_closure
  end
  def e_determinize() do
    #3: función e_determinize
  end
end
