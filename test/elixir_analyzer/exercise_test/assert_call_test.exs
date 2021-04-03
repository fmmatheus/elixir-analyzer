defmodule ElixirAnalyzer.ExerciseTest.AssertCallTest do
  use ElixirAnalyzer.ExerciseTestCase,
    exercise_test_module: ElixirAnalyzer.Support.AnalyzerVerification.AssertCall

  test_exercise_analysis "perfect solution",
    comments: [] do
    defmodule AssertCallVerification do
      def function() do
        result = helper()
        IO.puts(result)

        private_helper() |> IO.puts()
      end

      def helper do
        :helped
      end

      defp private_helper do
        :privately_helped
      end
    end
  end

  test_exercise_analysis "missing local call from anywhere in solution",
    comments: [
      "didn't find a local call to helper/0",
      "didn't find a local call to helper/0 within function/0"
    ] do
    defmodule AssertCallVerification do
      def function() do
        private_helper() |> IO.puts()
      end

      def helper do
        :helped
      end

      defp private_helper do
        :privately_helped
      end
    end
  end

  test_exercise_analysis "missing local call from specific function solution",
    comments: [
      "didn't find a local call to helper/0 within function/0",
      "didn't find a local call to private_helper/0 within function/0"
    ] do
    defmodule AssertCallVerification do
      def function() do
        other()
        IO.puts("1")
      end

      def other() do
        result = helper()
        private_helper() |> IO.puts()
      end

      def helper do
        :helped
      end

      defp private_helper do
        :privately_helped
      end
    end
  end

  test_exercise_analysis "missing call to IO.puts/1 in solution",
    comments: [
      "didn't find a call to IO.puts/1 anywhere in solution",
      "didn't find a call to IO.puts/1 in function/0"
    ] do
    defmodule AssertCallVerification do
      def function() do
        result = helper()
        private_helper()
      end

      def helper do
        :helped
      end

      defp private_helper do
        :privately_helped
      end
    end
  end

  test_exercise_analysis "missing call to IO.puts/1 in function/0 solution",
    comments: [
      "didn't find a call to IO.puts/1 in function/0"
    ] do
    defmodule AssertCallVerification do
      def function() do
        result = helper()
        private_helper() |> other()
      end

      def other(x) do
        IO.puts(x)
      end

      def helper do
        :helped
      end

      defp private_helper do
        :privately_helped
      end
    end
  end
end
