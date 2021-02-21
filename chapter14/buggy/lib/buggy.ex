defmodule Buggy do
  @moduledoc """
  Documentation for `Buggy`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Buggy.hello()
      :world

  """
  def parse_header(
    <<
      format::integer-16,
      tracks::integer-16,
      division::bits-16
    >>
  ) do
    # require IEx; IEx.pry # -> binding -> continue
    IO.puts "format: #{format}"
    IO.puts "tracks: #{tracks}"
    IO.puts "division: #{decode(division)}"
  end
  def decode(<< 0::1, beats::15 >>) do
    "四分音符 = #{beats}"
  end
  def decode(<< 1::1, fps::7, beats::8 >>) do
    "#{-fps} fps, #{beats}/frame"
  end
end
