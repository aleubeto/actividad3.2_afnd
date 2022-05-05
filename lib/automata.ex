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

  #2: función e_closure
  def e_closure_aux(delta, curr, stack) do
    Enum.map(curr, fn y -> {[y], nil}end)
    |> Enum.reduce(stack, fn key, visitedp ->
      y = delta[key]
      if y != nil do
        e_closure_aux(delta, y, [y | visitedp])
      else
        List.flatten(visitedp)
        |> Enum.uniq
      end
    end)
  end

  def e_closure(n, r) do
    Enum.reduce(r, r, fn q, acc -> e_closure_aux(n.delta, q, acc)end)
    |> Enum.sort()
  end
  #Ejecución: Automata.e_closure(IniciandoTT.a2, [P0])


  #3: función e_determinize
  def e_determinize() do
  end
end
