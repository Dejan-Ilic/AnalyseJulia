### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 5e7323ad-e66d-4f26-be3d-eb956c964761
using LinearAlgebra, Random, Plots #de extra Packages die je nodig hebt om deze notebook uit te kunnen voeren

# ╔═╡ 3518a9c4-1e79-4614-9a4e-6a8eb1989a5c
md"# Oefeningen Julia"

# ╔═╡ b4d1835d-4d98-43e0-bbe9-f4703ce01522
#installatie, enkel nodig als de vorige cel een error gaf. Verwijder wel eerst de commentaren.
#begin
#	using Pkg
#	Pkg.add("Random")
#	Pkg.add("LinearAlgebra")
#	Pkg.add("Plots")
#end

# ╔═╡ 7b432c3d-1cfe-4695-97c0-782205762f7c
md"## Reeks 15"

# ╔═╡ 3ed31100-cd36-11eb-28f3-61a5f9c838bd
md"###### Oefening 15.1
Beschouw de matrix 

$$A = \left[\begin{array}{cccc} 
2 & 5 & 3 & 4\\
3 & 2 & 1 & 0\\
8 & 0 & 1 & 1\\
3 & 3 & 2 & 0
\end{array}\right]$$

Bereken `B` de inverse van `A`."

# ╔═╡ 20fe8b87-ab5c-400b-ae9f-7bc2978e84a3
A = 0

# ╔═╡ dbdf98c0-8458-43a8-a2cd-533063c5beb4
B = 0

# ╔═╡ a2557675-d4ed-49fc-8d96-74ce910678b8
begin
	A_corr = [3 5 3 4; 3 2 1 0; 8 0 1 1; 3 3 2 0];
	B_corr = A_corr^(-1)  #of A_corr\I
	
	let
		a_ans = "incorrect"
		b_ans = "incorrect"

		try
			@assert A_corr == A
			a_ans = "correct"
		catch
			nothing
		end

		try
			@assert B_corr == B
			b_ans = "correct"
		catch
			nothing
		end

		md"Je hebt `A` **$a_ans** ingevoerd en `B` **$b_ans** berekend."
	end
end

# ╔═╡ 9333e93d-3722-4511-8511-438dbd2f0f03
md"Geldt dat `A*B = I`? Geldt dat `A*B == B*A`? Verklaar."

# ╔═╡ c63673da-0a97-4a60-a13a-a92470b7f4f6
#berekening 1

# ╔═╡ 152387c2-31cc-4fc4-b4e2-87cf980dcdb4
#berekening 2

# ╔═╡ b56aaea2-adfc-44fc-ad6a-44efddbcc76b
md"Bereken het kwadraat van `B` en noem dit resultaat `C`."

# ╔═╡ 5dbe3247-587a-432a-b2d0-2d14b065befd
C = 0;

# ╔═╡ 1048f459-de92-4785-97d5-1127d2632099
begin
	C_corr = B_corr^2
	
	try
		@assert C_corr == C
		md"Je hebt `C` **correct** berekend."
	catch
		md"Je hebt `C` **incorrect** berekend."
	end
end

# ╔═╡ 26da1268-0f15-4e74-a65e-91cb4db21e8b
md"Bekom `E` door de getransponeerde van `C` elementsgewijs met `D` te vermenigvuldigen: 

$$D = \left[\begin{array}{cccc} 
2 & 2 & 1 & 3\\
1 & 0 & 4 & 0\\
5 & 3 & 7 & 1\\
4 & 5 & 3 & 2
\end{array}\right]$$

"

# ╔═╡ 8aac73a3-b920-46ad-bf77-8e5b1e5b640f
D = 0

# ╔═╡ 8bcc6018-fb6e-4221-939e-c2a4a0c1ac2d
E = 0

# ╔═╡ 280c42a2-477e-46e3-8dcb-4db5e8a0f7bf
begin
	D_corr = [2 2 1 3; 1 0 4 0; 5 3 7 1; 4 5 3 2]
	E_corr = C_corr' .* D_corr
	
	E_corr == E ? md"Je oplossing is **correct**." : md"Je oplossing is **incorrect**."
end

# ╔═╡ fd595cc5-2ed6-4ddc-b8a7-d5e970d7cab8
md"Maak de vector

$$f = [\begin{array}{ccc}8 & 14 & 20]\end{array}$$
met behulp van een commando. Bouw vervolgens de matrix `G` na met behulp van de matrix `D`, de vector `f` en commando's. 

$$G = \left[\begin{array}{ccccc} 0 & 4 & 8 & 0 & 0\\ 3 & 7 & 0 & 14 & 0\\ 5 & 3 & 0 & 0 & 20\\2 & 0 & 0 & 0 & 0\\0 & 2 & 0 & 0 & 0\end{array}\right]$$

Bereken ten slotte de determinant `h` van `G`."

# ╔═╡ 223c6778-0eda-4170-ada7-10ca5181d9e3
f = 0

# ╔═╡ 83324317-bd52-4163-a07a-f0b8fc589e30
begin
function testcases(f::Function, correct::Function, cases::AbstractArray, compare::Function = isequal)
	function attempt(args...)
		try
			f(args...)
		catch
			"error"
		end
	end
	
	output = raw"""$$\begin{aligned}\begin{array}{|c|c|c|}
\hline
\text{test invoer} & \text{jouw antw.} & \text{correct antw.}\\
\hline """
	iscorrect = true
	
	for case in cases
		a = attempt(case...)
		b = correct(case...)
		
		a_eq_b = compare(a,b)
		
		iscorrect = iscorrect && a_eq_b
		
		a_colored = (a_eq_b) ? string(a) : raw"\textcolor{red}{" * string(a) *"}"
				
		output *= string(case) * " & " * a_colored * " & " * string(b) * raw"\\ "
	end
		
	
	antw = iscorrect ? "correct" : "incorrect"
	
	output = "Je antwoord was **$antw**:\n\n\n" * output * raw"\hline\end{array}\end{aligned}$$"
		
	
	return Markdown.parse(output)
end

	#voorbeeld gebruik van de testcases functie
	let f(x) = 3*x + 2, g(x) = 3*x + rand(0:3)
		c = [1 2 3 4 5 6]

		testcases(f,g,c) 
	end
	
	md"Interactieve oefeningen Julia. Respecteer bij alle oefeningen de naamgeving zodat de automatische verbetering functioneert. Omdat er bij sommige oefeningen meerdere manieren mogelijk zijn om tot een oplossing te komen, werkt de automatische verbetering daar aan de hand van een aantal *testcases*. Je kan je oplossing ook steeds vergelijking met de oplossing die wij achter de schermen gebruiken door op het oogje te klikken naast de relevante blokken."
end

# ╔═╡ 4c9353e0-982d-49c2-b45a-28a910b1489b
G = 0

# ╔═╡ d5802fea-96d6-4c4e-8433-0ac487338b43
h = 0

# ╔═╡ 8abe9956-cd72-4200-aee1-1d7257bb0ae8
begin
	f_corr = collect(8:6:20)'
	G_corr = zeros(Int, 5, 5)
	G_corr[1:3, 1] = D_corr[2:4, 2]
	G_corr[1:3, 2] = D_corr[2:4, 3]
	G_corr[5, 2] = 2
	G_corr[1:3, 3:5] = diagm(f_corr')
	G_corr[4:5, 1:2] = diagm([2,2])
	
	h_corr = det(G_corr)
	if abs(h - h_corr) < 0.001
		md"Je oplossing is **correct**."
	else
		md"Je oplossing is **incorrect**."
	end
end
	

# ╔═╡ 2d36128a-236a-419b-97f0-375a4d1fdf47
md"""###### Oefening 15.2 a)
Schrijf de functie `myabs(x)` die de absolute waarde van `x` berekent. Je kan altijd cellen bijmaken om je functies in te testen door op de ``+`` te drukken, links. Als je dan een fout maakt in je functie, worden je errors in meer detail toegelicht dan in de tabel."""

# ╔═╡ ef585606-af09-4f8c-a310-7bd5b1507bf4
function myabs(x)
	
end

# ╔═╡ 2c38594b-d0bf-4a68-905c-a6a1bcaa5b5b
let
	function corr_abs(x)
		if x<0
			return -x
		else
			return x
		end
	end
	testcases(myabs, corr_abs, -3:3)
end

# ╔═╡ 0be39fb4-b66f-4a52-b4f5-a5a91347e41b
md"""###### Oefening 15.2 b)
Scrhijf de functie `mysign(x)` die het teken van `x` teruggeeft (i.e. +1 of -1)"""

# ╔═╡ 146b4d06-ed47-4231-a63b-c17eae07fd2c
function mysign(x)
	
end

# ╔═╡ 0764b4ef-cd5c-4faf-b00e-ab1602b05853
let 
	function corr_sign(x)
		if x < 0
			return -1
		elseif x > 0
			return 1
		else
			return 0 #voor 0 de w
		end
	end
	
	testcases(mysign, corr_sign, -3:3)
end

# ╔═╡ 56ff6d62-a261-4e9f-ba66-9e6dbc542c34
try
	t = rand(100) .- 0.5
	@assert sign.(t) == mysign.(t)
	md"""Je oplossing is **correct**"""
catch
	md"""Je oplossing is **incorrect**"""
end

# ╔═╡ 36188a03-fb78-4cea-aaba-438ec9e7a0d7
md"""###### Oefening 15.2 c)
Scrhijf de functie `mypower(a, n)` die ``a^n`` berekent met `n` een natuurlijk getal"""

# ╔═╡ 4ca6c1f1-7466-4ca1-a02a-c6e9a08826b2
function mypower(a, n)
	
end

# ╔═╡ 1cac8809-1ca3-4e82-936b-45e711d2f791
testcases(mypower, (a,n) -> a^n, [(2,1), (3,4), (5,6)])

# ╔═╡ 8483b480-e35e-4de3-9f9f-31c7c5c59b59
md"###### Oefening 15.3
Schrijf de functie van Ackerman

$$Ack(x,y) = \left\{\begin{array}{ll}
0 & y=0\\
2y & x=0\\
2 & y=1\\
Ack((x-1), Ack(x, y-1)) & \text{anders}
\end{array}\right.$$"

# ╔═╡ ee0155ca-0e9c-4674-837e-c9e28b9eac68
function Ack(x,y)
	
end

# ╔═╡ da297cab-4fd5-4e49-aa1e-f51ea0a971e7
#test je Ack functie hier

# ╔═╡ f758dfd7-fb63-4ead-bfa1-176a9ff24715
let
	function Ack_corr(x, y)
		if y == 0
			return 0
		elseif x == 0
			return 2*y
		elseif y == 1
			return 2
		else
			return Ack_corr(x-1, Ack_corr(x, y-1))
		end
	end
	
	testcases(Ack, Ack_corr, [(x, y) for x=0:3, y=0:3][:])
end

# ╔═╡ c56e007a-1a17-4594-aeab-8da839095586
md"###### Oefening 15.4
Schrijf een functie `schrikkel(n)` die als resultaat een `true` geeft als `n` een schrikkeljaar is en `false` indien niet. Schrikkeljaren zijn jaren waarvan de jaartallen deelbaar zijn door `4`, maar niet deelbaar door `100`, tenzij het jaartal deelbaar is door `400`, in welk geval het toch een schrikkeljaar is."

# ╔═╡ 0b0d7be3-3f1e-479b-a7c4-7429f9f6fafd
function schrikkel(n)
	
end

# ╔═╡ 630eea16-d14f-4fe7-b7ef-49e9b0dcf6c6
let
function schrikkel_corr(n)
	if n%400 == 0
		return true
	elseif n%4 == 0
		if n%100 == 0
			return false
		else
			return true
		end
	else 
		return false
	end
end
	testcases(schrikkel, schrikkel_corr, [1600, 1748, 1800, 1900, 1901, 2000, 2002, 2020])
end

# ╔═╡ 063d5887-38bf-4dc5-9663-bea913cd1781
md"###### Oefening 15.5
Schrijf een functie `sol(x,y,z)` die als resultaat de som van de twee grootste getallen geeft."

# ╔═╡ 8e12b3d0-98ae-4e31-8414-ade6234071db
function sol(x, y, z)

end

# ╔═╡ 00f4a370-2c61-466d-b2b1-abf8061cee3a
let
	function sol_corr(x,y,z)
		if x <= y && x <= z
			return y + z
		elseif y <= x && y <= z
			return x + z
		else
			return x + y
		end
	end
	
	function sol_elegant_recursief(x, y, z)
		if x <= y && x <= z
			return z + y
		else
			return sol(y, z, x)
		end
	end
	
	testcases(sol, sol_corr, [(rand(0:9), rand(0:9), rand(0:9)) for i=1:10])
end

# ╔═╡ 8fd3c053-7a63-4366-aa11-2b6fe51e422d
md"###### Oefening 15.6
 Schrijf een functie `geslaagd(a,m,s)` die als resultaat `true` geeft als de student, die als punten `a`, `m` en `s` heeft behaald, een gemiddelde hoger of gelijk aan 11.6 op 20 heeft,
en `false` anders. `a`, `m` en `s` zijn cijfers op 20. De berekening van het gemiddelde is als volgt: elk cijfer hoger of gelijk aan 10 heeft gewicht 1, elk cijfer onder de 10 heeft gewicht 2. Een cijfer
onder de 10 weegt dus dubbel zo zwaar als een cijfer hoger of gelijk aan 10."

# ╔═╡ b21599c7-a2bc-4549-b693-3c475e8fe82e
function geslaagd(a,m,s)
	
end

# ╔═╡ 32e2fa61-5d26-482d-bbc3-29000ebe2c86
let
	function geslaagd_corr(a,m,s)
		gewicht = 3
		if a < 10
			a *= 2
			gewicht += 1
		end
		if m < 10
			m *= 2
			gewicht += 1
		end
		if s < 10
			s *= 2
			gewicht += 1
		end

		return (a + m + s)/gewicht >= 11.6
	end
	
	testcases(geslaagd, geslaagd_corr, [(rand(5:20),rand(5:20),rand(5:20)) for k=1:10])
end
	

# ╔═╡ 463b4cd1-a32e-4acf-a0ea-2cb71ff52759
md"###### Oefening 15.7
Schrijf een functie `curt(a)` die de derdematchswortel van `a` berekent door gebruik te maken van het algoritme van Newton om een nulpunt van een vergelijking ``f(x) = x^3 - a = 0`` te benaderen. Dit algoritme is
```math 
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}
```
"

# ╔═╡ 40f838a2-9202-426f-b027-c783ef56fe4e
function curt(a)
	
end

# ╔═╡ 01b62f90-8bca-4b89-a702-59a31118ff3e
let 
	function curt_corr(a)
		x = a < 0 ? -0.5 : 0.5 #kies startwaarde
	
		f(t) = t^3 - a #compacte function definitie
		df(t) = 3*t^2

		for i=1:1000 #maximaal 1000 iteraties

			x = x - f(x)/df(x)
			if abs(x^3 - a) <= 10e-5
				break #breek de for-lus af
			end

		end
		return x
	end
	
	function curt_ingebouwd(a) #een beetje valsspelen om de echte antwoorden te krijgen
		return round(Int, sign(a) * (abs(a)^(1/3)))
	end
	
	testcases(curt, curt_ingebouwd, [k^3 for k=[collect(-4:-1); collect(1:4)]], (x,y) ->(abs( (typeof(x) <: Real ? x : 0) - y) < 0.00001))
end

# ╔═╡ 07f4c04b-d505-47db-beb4-41490eec4efc
md" ###### Oefening 15.8
Schrijf een functie `integraal(N)` die ``\int_0^1e^{x^2} dx`` benadert met een linkersom met `N` stappen, i.e.
```math
I = \frac{1}{N}\Big(f(x_0) + f(x_1) + \ldots + f(x_{N-1})\Big)
```"

# ╔═╡ f694f9f7-60eb-4312-93f5-6c6ce8c4c0ca
function integraal(N)
	
end

# ╔═╡ 412d4f34-6491-48f3-8dc0-f1d909e0d1a5
let
	function integraal_corr(N)
		f(t) = exp(t^2)
		return 1/N * sum( f(n/N) for n =0:N-1)
	end
	
	function integraal_minder_elegant_maar_ook_juist(N)
		totaal = 0
		
		for k=0:N-1
			x = k/N
			totaal += exp(x^2)
		end
		
		return 1/N * totaal
	end
	
	testcases(integraal, integraal_corr, [10 100 1000], (x,y) -> (abs((typeof(x) <: Real ? x : 0)-y) < 0.00001))
end

# ╔═╡ c3ee3749-22dd-4ac5-9cef-0ff5ef874263
md"## Reeks 16"

# ╔═╡ 14075eef-48d9-4640-bf05-67dea2a42fca
md"###### Oefening 16.1
Schrijf een functie `is_in(M, x)` die als resultaat `true` geeft als minstens een van de elementen van `M` gelijk is aan `x` en anders `false`."

# ╔═╡ 30126cd3-2415-4f23-aa79-346b4858892c
function is_in(M, x)
	
end

# ╔═╡ 72d18d2d-1f15-4dff-a851-2b9ad6fea391
let
	function is_in_corr(M, x)
		for i=1:length(M)
			if M[i] == x
				return true
			end
		end
		return false
	end
	function is_in_corr2(M, x)
		for el in M
			if el == x
				return true
			end
		end
		return false
	end
	
	testcases(is_in, is_in_corr, [ (rand(0:9, rand(3:6)), rand(0:9)) for k=1:8])
end

# ╔═╡ f8d31e43-f886-4385-9ae0-845222404a3f
md"###### Oefening 16.2 a)
Schrijf een functie `maxi(rij)` die het maximum zoekt in een gegeven Vector/Matrix/Array."

# ╔═╡ f89f7936-51ca-4757-875d-febfaced9615
function maxi(rij)
	
end

# ╔═╡ 09e5f760-a0e9-459a-972c-a6323fb8de51
let
	function maxi_corr(rij)
		m = rij[1]
		for i=2:length(rij)
			if rij[i] > m
				m = rij[i]
			end
		end
		return m
	end
	
	testcases(maxi, maxi_corr, [(rand(0:9, 5),) for k=1:7])
end

# ╔═╡ b6618bd7-ac42-4571-bd93-a420753e0f7f
md"###### Oefening 16.2 b)
Schrijf een functie `posmaxi(rij)` die de index van het maximum zoekt in een gegeven Vector/Matrix/Array."

# ╔═╡ 4e5e0bda-14b1-4dac-b919-d4eda8d00c09
function posmaxi(rij)
	
end

# ╔═╡ 6f26b451-eb7e-4a17-a0cd-3642a4aeaafb
let
	function posmaxi_corr(rij)
		maxidx = 1
		for i=2:length(rij)
			if rij[i] > rij[maxidx]
				maxidx = i
			end
		end
		return maxidx
	end
	
	testcases(posmaxi, posmaxi_corr, [(rand(0:9, 5),) for k=1:7])
end

# ╔═╡ 3b266933-7442-4687-8c1b-ef07dc13ad5a
md"###### Oefening 16.2 c) 
Schrijf een functie `posmaxifrom(rij, startindex)` die de index van het maximum vanaf een gegeven index zoekt in een gegeven rijmatrix."

# ╔═╡ 822885a7-d171-4e37-9546-4fb9f20d1462
function posmaxifrom(rij, startindex)
	
end

# ╔═╡ 3d59cf67-329e-4cb4-b779-b01fbcba632f
let
	function posmaxifrom_corr(rij, startindex)
		maxidx = startindex
		for i=(maxidx+1):length(rij)
			if rij[i] > rij[maxidx]
				maxidx = i
			end
		end
		return maxidx
	end
	
	testcases(posmaxifrom, posmaxifrom_corr, [(rand(0:9, 5), rand(1:5)) for k=1:7])
end

# ╔═╡ 04028c92-329e-49f4-ad26-dbd6c0a483b7
md"###### Oefening 16.3
Schrijf een functie `multifib(M, k)`, waarbij ``M`` een ``n\times2`` matrix is en ``k`` een natuurlijk getal, die als resultaat een ``n\times (2+k)`` matrix geeft waarbij elke rij een Fibonacci rij is. Een Fibonacci rij is een rij getallen waar elk element de som van de twee voorgaande is.
"

# ╔═╡ 5d92b351-69aa-4cea-9534-09fe44a6d3d2
md"""###### Oefening 16.4
Schrijf een functie `merge(rij1, rij2)` die 2 rijen samenvoegt, waarbij de ele-
menten van de ene rij afgewisseld worden met elementen van de andere rij. We beginnen met een
element van de eerste rij en als een rij "opgebruikt" is, vullen we aan met de resterende elementen
uit de andere rij."""

# ╔═╡ 762be3b6-0be2-4368-8e51-d696357ff6cc
function merge(rij1, rij2)

end

# ╔═╡ 070d6a89-112b-4e80-b142-ca7c567628b8
let
	function merge_corr(rij1, rij2)
		l1 = length(rij1)
		l2 = length(rij2)
		
		rij3 = zeros(eltype(rij1), l1 + l2)
		idx1 = 1
		idx2 = 1
		
		while true
			klaar = true
			
			if idx1 <= l1
				rij3[idx1 + idx2 - 1] = rij1[idx1]
				idx1 += 1
				klaar = false
			end
			
			if idx2 <= l2
				rij3[idx1 + idx2 - 1] = rij2[idx2]
				idx2 += 1
				klaar = false
			end
			
			if klaar
				break
			end
		end
		return rij3
	end

					
	testcases(merge, merge_corr, [(rand(0:9, rand(2:5)), rand(0:9, rand(2:4))) for k=1:7])
end
				

# ╔═╡ d754bd1a-3cea-408a-99d1-1525f574847f
md"###### Oefening 16.5 
Schrijf een functie `splitt(rij)` die als resultaat twee rijen geeft, waarbij de eerste rij alle elementen op oneven positie bevat, en de andere rij alle elementen op even positie"

# ╔═╡ 52207a3e-7894-4606-afd6-3c757cdf6646
function splitt(rij)
	
end

# ╔═╡ 38a65bfd-00a7-4aad-b924-9eaca5132939
let
	function splitt_corr(rij)
		return [rij[2*k] for k=1:floor(Int, length(rij)/2)], [rij[2*k - 1] for k=1:ceil(Int, length(rij)/2)]
	end
	testcases(splitt, splitt_corr, [(rand(0:9, rand(4:7)), ) for k=1:7])
end

# ╔═╡ c569b18f-b902-4d5d-abe3-5ce54f1316e4
md"## Reeks 17"

# ╔═╡ 008339f1-267e-4d08-bf61-c5f43633e1d5
md"Schrijf een functie `ruit(n)` die een ``n\times n`` matrix (met ``n`` oneven) van de volgende vorm genereert:

$$\left[\begin{array}{ccccc}
0&0&1&0&0\\
0&1&1&1&0\\
1&1&1&1&1\\
0&1&1&1&0\\
0&0&1&0&0
\end{array}\right]$$"

# ╔═╡ aabab6cc-383d-4abd-8a8b-83a98e9c6705


# ╔═╡ bfd3d486-2011-4d57-b0d9-b418563c4714
#test je code hier

# ╔═╡ e5866311-89a3-4262-914c-9efb5e31b89a
md"###### Oefening 17.2 a)
Schrijf een functie `SolveLT(L, b)` die het stelsel ``Lx=b`` oplost waarbij ``L`` een vierkante onderdriehoeksmatrix is."

# ╔═╡ 19ea3eeb-26f1-47b5-8125-a14e9d5780ef
function SolveLT(L, b)
	
end

# ╔═╡ 5c608409-259e-4044-898e-3af2570c2df1
let
	
end

# ╔═╡ f036f013-9658-4c90-8a11-a20e2f97c8e6
md"###### Oefening 17.2 b)
Schrijf een functie `SolveUT(U, b)` die het stelsel ``Ux=b`` oplost waarbij ``U`` een vierkante bovendriehoeksmatrix is."

# ╔═╡ 0579056b-c79b-4682-84f0-4aa64a96b58b
function SolveUT(U, b)
	
end

# ╔═╡ a09cd03c-93c1-41b6-9767-507dce6707c2
let
	
end

# ╔═╡ 4b8181c7-a6fb-4655-956b-c7579ce283c4
md"###### Oefening 17.3 a) 
Schrijf een functie `omzetting(t)` die de omzetting doet van graden Celsius (`TC`) naar Fahrenheit (`TF`):

$$TF = \frac{9}{5}TC + 32$$"

# ╔═╡ 0c68d669-9f95-4d82-b05d-babb6a68f465
#definitie

# ╔═╡ 85cd8816-3ef3-421f-9b1b-a53c11b52c51
let
	omzetting_corr(TC) = 9/5 * TC + 32;
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ a3a513df-f407-4896-984d-c544206d4eab
md"###### Oefening 17.3 b) 
Maak een tabel voor de omzetting van 0°C t.e.m. 100°C."

# ╔═╡ 009120ad-13c0-49fd-9ac0-918c28937044
#tabel

# ╔═╡ 8843815f-09bd-4cbe-8892-454cf2c036e4
md"###### Oefening 17.3 c) 
Plot de functie `omzetting` van `0` tot `100`."

# ╔═╡ 6e985588-6f26-4da2-a5d1-3b736acc94f0
#plot

# ╔═╡ be5b83b7-17f4-42bd-aa1d-2aba45046feb
md"###### Oefening 17.4 a)
Schrijf een functie `plotgauss(begin, einde, stap)` die de gausskromme

$$f(x) = e^{-\frac{x^2}{2}}$$

plot tussen het opgegeven interval met de opgegeven precisie."

# ╔═╡ e47d8341-d15e-4daf-b48d-396bab9cf094
#functie

# ╔═╡ 0c8f6b43-5af9-4627-9750-56533bc4c7d6
#test

# ╔═╡ 79ed86dd-224f-4f87-9e1b-f5784b1f2195
md"###### Oefening 17.4 b)
Schrijf een tweede functie `raaklijngauss(a)` die de raaklijn aan de gausskrommen tekent voor opgegeven ``x``-coördinaat ``a``"

# ╔═╡ 3e22c469-9054-4899-808a-b2c417d37859
#definitie

# ╔═╡ e538e97c-a75c-4c7a-9d66-a2feda0d71bd
#test

# ╔═╡ c51d9046-95ef-49d5-a169-65a56036502b
let
	function raaklijngauss_corr(a)
		
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 66941cc9-cd14-45ef-a821-2bd803cc78da
md"###### Oefening 17.5 
Schrijf een programma `plotcurt(a)` dat de methode van Newton grafisch voorstelt zoals toegepast in oefening 15.7, voor het programma `curt(a)`."

# ╔═╡ de6cdaf8-cd42-4186-88dd-8a8568b141d4
#definitie

# ╔═╡ 02bd929b-cc0f-4986-a843-a123c9d657c2
#test

# ╔═╡ ae00fcbb-b1dc-46a7-8bf9-cbc3b06b41e1
let
	function plotcurt_corr(a)
	
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ e37e343a-6161-4ed1-9e13-425afaed4046
md"Definieer de functie

$$s(x) = \frac{x - \sin(x)}{x^3}$$

Bereken achtereenvolgens `s(0.01)`, `s(0.001)`, `s(0.0001)` en `s(0.00001)` en plot vervolgens `s` op het interval ``[-3, 3]``."

# ╔═╡ 8bdcef66-5e66-40ef-9526-12fe58df2254
#definitie

# ╔═╡ 868e5192-1989-4382-ba42-d70c96ce4d55
#berekeningen

# ╔═╡ 3d30ab38-fc39-45b6-a379-b3de6238dd58
#plot

# ╔═╡ 35debdb4-f14a-47ea-8b6c-b1d37026e1f1
let 
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 200b252f-b222-4e92-b1bc-bd6cfca9d7e9
md"###### Oefening 17.7
Definieer de matrix

$$P = \left[\begin{array}{ccc} 1&2&0\\0&1&2\\2&0&1\end{array}\right]$$

en bereken de eerst 10 machten van `P`. Controleer welke macht van `A` mogelijk is onder de voorwaarde dat alle elementen in deze macht kleiner zijn dan ``10^6``."


# ╔═╡ f612a493-0387-48b5-bce0-4a00bbfd2b87


# ╔═╡ da6a8303-dfd7-4e39-8667-99f56037ce17


# ╔═╡ 21d0a957-1bac-4fd9-aa26-1389c3cd6a2a


# ╔═╡ 9b53b6ca-7751-40b7-8b92-1af6275b6cac


# ╔═╡ Cell order:
# ╟─3518a9c4-1e79-4614-9a4e-6a8eb1989a5c
# ╟─83324317-bd52-4163-a07a-f0b8fc589e30
# ╠═5e7323ad-e66d-4f26-be3d-eb956c964761
# ╠═b4d1835d-4d98-43e0-bbe9-f4703ce01522
# ╟─7b432c3d-1cfe-4695-97c0-782205762f7c
# ╟─3ed31100-cd36-11eb-28f3-61a5f9c838bd
# ╠═20fe8b87-ab5c-400b-ae9f-7bc2978e84a3
# ╠═dbdf98c0-8458-43a8-a2cd-533063c5beb4
# ╟─a2557675-d4ed-49fc-8d96-74ce910678b8
# ╟─9333e93d-3722-4511-8511-438dbd2f0f03
# ╠═c63673da-0a97-4a60-a13a-a92470b7f4f6
# ╠═152387c2-31cc-4fc4-b4e2-87cf980dcdb4
# ╟─b56aaea2-adfc-44fc-ad6a-44efddbcc76b
# ╠═5dbe3247-587a-432a-b2d0-2d14b065befd
# ╟─1048f459-de92-4785-97d5-1127d2632099
# ╟─26da1268-0f15-4e74-a65e-91cb4db21e8b
# ╠═8aac73a3-b920-46ad-bf77-8e5b1e5b640f
# ╠═8bcc6018-fb6e-4221-939e-c2a4a0c1ac2d
# ╟─280c42a2-477e-46e3-8dcb-4db5e8a0f7bf
# ╟─fd595cc5-2ed6-4ddc-b8a7-d5e970d7cab8
# ╠═223c6778-0eda-4170-ada7-10ca5181d9e3
# ╠═4c9353e0-982d-49c2-b45a-28a910b1489b
# ╠═d5802fea-96d6-4c4e-8433-0ac487338b43
# ╟─8abe9956-cd72-4200-aee1-1d7257bb0ae8
# ╟─2d36128a-236a-419b-97f0-375a4d1fdf47
# ╠═ef585606-af09-4f8c-a310-7bd5b1507bf4
# ╟─2c38594b-d0bf-4a68-905c-a6a1bcaa5b5b
# ╟─0be39fb4-b66f-4a52-b4f5-a5a91347e41b
# ╠═146b4d06-ed47-4231-a63b-c17eae07fd2c
# ╟─0764b4ef-cd5c-4faf-b00e-ab1602b05853
# ╟─56ff6d62-a261-4e9f-ba66-9e6dbc542c34
# ╟─36188a03-fb78-4cea-aaba-438ec9e7a0d7
# ╠═4ca6c1f1-7466-4ca1-a02a-c6e9a08826b2
# ╠═1cac8809-1ca3-4e82-936b-45e711d2f791
# ╟─8483b480-e35e-4de3-9f9f-31c7c5c59b59
# ╠═ee0155ca-0e9c-4674-837e-c9e28b9eac68
# ╠═da297cab-4fd5-4e49-aa1e-f51ea0a971e7
# ╟─f758dfd7-fb63-4ead-bfa1-176a9ff24715
# ╟─c56e007a-1a17-4594-aeab-8da839095586
# ╠═0b0d7be3-3f1e-479b-a7c4-7429f9f6fafd
# ╟─630eea16-d14f-4fe7-b7ef-49e9b0dcf6c6
# ╟─063d5887-38bf-4dc5-9663-bea913cd1781
# ╠═8e12b3d0-98ae-4e31-8414-ade6234071db
# ╟─00f4a370-2c61-466d-b2b1-abf8061cee3a
# ╟─8fd3c053-7a63-4366-aa11-2b6fe51e422d
# ╠═b21599c7-a2bc-4549-b693-3c475e8fe82e
# ╟─32e2fa61-5d26-482d-bbc3-29000ebe2c86
# ╟─463b4cd1-a32e-4acf-a0ea-2cb71ff52759
# ╠═40f838a2-9202-426f-b027-c783ef56fe4e
# ╟─01b62f90-8bca-4b89-a702-59a31118ff3e
# ╟─07f4c04b-d505-47db-beb4-41490eec4efc
# ╠═f694f9f7-60eb-4312-93f5-6c6ce8c4c0ca
# ╟─412d4f34-6491-48f3-8dc0-f1d909e0d1a5
# ╟─c3ee3749-22dd-4ac5-9cef-0ff5ef874263
# ╟─14075eef-48d9-4640-bf05-67dea2a42fca
# ╠═30126cd3-2415-4f23-aa79-346b4858892c
# ╟─72d18d2d-1f15-4dff-a851-2b9ad6fea391
# ╟─f8d31e43-f886-4385-9ae0-845222404a3f
# ╠═f89f7936-51ca-4757-875d-febfaced9615
# ╟─09e5f760-a0e9-459a-972c-a6323fb8de51
# ╟─b6618bd7-ac42-4571-bd93-a420753e0f7f
# ╠═4e5e0bda-14b1-4dac-b919-d4eda8d00c09
# ╟─6f26b451-eb7e-4a17-a0cd-3642a4aeaafb
# ╟─3b266933-7442-4687-8c1b-ef07dc13ad5a
# ╠═822885a7-d171-4e37-9546-4fb9f20d1462
# ╟─3d59cf67-329e-4cb4-b779-b01fbcba632f
# ╟─04028c92-329e-49f4-ad26-dbd6c0a483b7
# ╟─5d92b351-69aa-4cea-9534-09fe44a6d3d2
# ╠═762be3b6-0be2-4368-8e51-d696357ff6cc
# ╟─070d6a89-112b-4e80-b142-ca7c567628b8
# ╟─d754bd1a-3cea-408a-99d1-1525f574847f
# ╠═52207a3e-7894-4606-afd6-3c757cdf6646
# ╟─38a65bfd-00a7-4aad-b924-9eaca5132939
# ╟─c569b18f-b902-4d5d-abe3-5ce54f1316e4
# ╠═008339f1-267e-4d08-bf61-c5f43633e1d5
# ╠═aabab6cc-383d-4abd-8a8b-83a98e9c6705
# ╠═bfd3d486-2011-4d57-b0d9-b418563c4714
# ╠═e5866311-89a3-4262-914c-9efb5e31b89a
# ╠═19ea3eeb-26f1-47b5-8125-a14e9d5780ef
# ╠═5c608409-259e-4044-898e-3af2570c2df1
# ╠═f036f013-9658-4c90-8a11-a20e2f97c8e6
# ╠═0579056b-c79b-4682-84f0-4aa64a96b58b
# ╠═a09cd03c-93c1-41b6-9767-507dce6707c2
# ╠═4b8181c7-a6fb-4655-956b-c7579ce283c4
# ╠═0c68d669-9f95-4d82-b05d-babb6a68f465
# ╠═85cd8816-3ef3-421f-9b1b-a53c11b52c51
# ╠═a3a513df-f407-4896-984d-c544206d4eab
# ╠═009120ad-13c0-49fd-9ac0-918c28937044
# ╠═8843815f-09bd-4cbe-8892-454cf2c036e4
# ╠═6e985588-6f26-4da2-a5d1-3b736acc94f0
# ╠═be5b83b7-17f4-42bd-aa1d-2aba45046feb
# ╠═e47d8341-d15e-4daf-b48d-396bab9cf094
# ╠═0c8f6b43-5af9-4627-9750-56533bc4c7d6
# ╠═79ed86dd-224f-4f87-9e1b-f5784b1f2195
# ╠═3e22c469-9054-4899-808a-b2c417d37859
# ╠═e538e97c-a75c-4c7a-9d66-a2feda0d71bd
# ╠═c51d9046-95ef-49d5-a169-65a56036502b
# ╠═66941cc9-cd14-45ef-a821-2bd803cc78da
# ╠═de6cdaf8-cd42-4186-88dd-8a8568b141d4
# ╠═02bd929b-cc0f-4986-a843-a123c9d657c2
# ╠═ae00fcbb-b1dc-46a7-8bf9-cbc3b06b41e1
# ╠═e37e343a-6161-4ed1-9e13-425afaed4046
# ╠═8bdcef66-5e66-40ef-9526-12fe58df2254
# ╠═868e5192-1989-4382-ba42-d70c96ce4d55
# ╠═3d30ab38-fc39-45b6-a379-b3de6238dd58
# ╠═35debdb4-f14a-47ea-8b6c-b1d37026e1f1
# ╠═200b252f-b222-4e92-b1bc-bd6cfca9d7e9
# ╠═f612a493-0387-48b5-bce0-4a00bbfd2b87
# ╠═da6a8303-dfd7-4e39-8667-99f56037ce17
# ╠═21d0a957-1bac-4fd9-aa26-1389c3cd6a2a
# ╠═9b53b6ca-7751-40b7-8b92-1af6275b6cac
