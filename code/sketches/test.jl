# https://yaoquantum.org/tutorials/quick-start/2.yao_basics/

cd(@__DIR__)
import Pkg
Pkg.activate(".")

using Yao, YaoPlots

A(i, j) = control(i, j=>shift(2π/(1<<(i-j+1))))

B(n, k) = chain(n, j==k ? put(k=>H) : A(j, k) for j in k:n)

qft(n) = chain(B(n, k) for k in 1:n)

plot(qft(3))

plot(chain(X, Y, H))

plot(put(5, 2=>H))

plot(control(5, 3, 2=>H))

qft(3)


@doc ArrayReg
# 
using YaoExtensions

variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]) |> plot

r = zero_state(5)

r |> variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1])

expect(heisenberg(5), r)

expect(heisenberg(5), r=>variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]))

reg, ∇θ = expect'(heisenberg(5), zero_state(5)=>variational_circuit(5, 3, [1=>2, 2=>3, 3=>4, 4=>5, 5=>1]))