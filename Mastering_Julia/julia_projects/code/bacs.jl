#
# bacs.jl
#
# Консольная игра "Быки и коровы" (Bulls And CowS)
#

function bacs()
  bulls = cows = turns = 0
  A = Any[]
  srand(round(Int, time()))

  while length(unique(A)) < 4
    push!(A,rand('1':'9'))
  end

  bacs_number = unique(A)
  println("Быки и коровы")

  while (bulls != 4)
    print("Ваша догадка? ")
    if eof(STDIN)
      s = "q"
    else
      s = chomp(readline(STDIN))
    end
    if (s == "q")
      print("Моя догадка была "); [print(bacs_number[i]) for i=1:4]
      return
    end

    guess = collect(s)
    if !(length(unique(guess)) == length(guess) == 4 && 
    all(isdigit,guess))
      print("\nВведите четыре различных цифры или q чтобы выйти: ")
      continue
    end

    bulls = sum(map(==, guess, bacs_number))
    cows = length(intersect(guess,bacs_number)) - bulls
    println("Быки: $bulls и коровы: $cows !")
    turns += 1
  end
  println("Вы угадали мое число за $turns раунд(ов).")
end
