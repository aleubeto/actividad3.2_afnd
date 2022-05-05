defmodule Automata do

  #1: función determinize
  def setter([]), do: [[]]  #Caso base
  def setter([h|t]) do
    tail = setter(t)
    setter(h, tail, tail)
  end
  defp setter(_, [], acc), do: acc
  defp setter(y, [h|t], acc), do: setter(y, t, [[y|h] | acc])

  def deltap(n) do
    a_states = setter(n.states)
    deltav =  for estado <- a_states, transicion <- n.alpha do
                {{estado, transicion},
                  Enum.map(estado, fn conjunto -> n.delta[{conjunto, transicion}] end)
                  |> List.flatten
                }
              end
    {a_states, deltav}
  end

  def determinize(n) do
    {a_states, deltav} = deltap(n)
    %{
      alpha: n.alpha,
      states: a_states,
      istates: [n.istates],
      fstates: Enum.filter(a_states,fn r -> Enum.any?(r, fn e->e in n.fstates end)end),
      delta: deltav |> Map.new()
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
