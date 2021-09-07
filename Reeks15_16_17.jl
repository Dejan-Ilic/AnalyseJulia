### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 5e7323ad-e66d-4f26-be3d-eb956c964761
using LinearAlgebra, Random, Plots #de extra Packages die je nodig hebt om deze notebook uit te kunnen voeren

# ╔═╡ 3518a9c4-1e79-4614-9a4e-6a8eb1989a5c
md"# Oefeningen Julia II"

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
	A_corr = [2 5 3 4; 3 2 1 0; 8 0 1 1; 3 3 2 0];
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
	
	md"Interactieve oefeningen Julia. Respecteer bij alle oefeningen de naamgeving zodat de automatische verbetering functioneert. Omdat er bij sommige oefeningen meerdere manieren mogelijk zijn om tot een oplossing te komen, werkt de automatische verbetering daar aan de hand van een aantal *testcases*. Je kan je oplossing ook steeds vergelijking met de oplossing die wij achter de schermen gebruiken door op het oogje te klikken naast de relevante blokken.
	
Ten slotte raden we je aan om zo veel mogelijk cell bij te maken (door op de plus tussen twee cellen te klikken) om in te experimenteren. Let wel, dit is een grote notebook, met vele voorgedefinieerde variabelen. Als je een variabele maakt met dezelfde naam als een reeds bestaande variabele zul je een error krijgen. Wees dus creatief met de naamgeving van eigen variabelen, of plaats je code binnen een `let ... end` blok.
	
	"
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
	G_corr[1:3, 3:5] = diagm(f_corr') #diagm(vec([8 14 20]) of diagm([8,14,20]) ook
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
Schrijf een functie `curt(a)` die de derdemachtswortel van `a` berekent door gebruik te maken van het algoritme van Newton om een nulpunt van een vergelijking ``f(x) = x^3 - a = 0`` te benaderen. Dit algoritme is
```math 
x_{n+1} = x_n - \frac{f(x_n)}{f'(x_n)}
```
"

# ╔═╡ 40f838a2-9202-426f-b027-c783ef56fe4e
function curt(a)
	
end

# ╔═╡ 01b62f90-8bca-4b89-a702-59a31118ff3e
begin 
	function curt_corr(a)
		x = a < 0 ? -0.5 : 0.5 #kies startwaarde (we willen niet door 0 delen)
	
		f(t) = t^3 - a #compacte function definitie
		df(t) = 3*t^2

		for i=1:100 #maximaal 1000 iteraties

			x = x - f(x)/df(x)
			if abs(x^3 - a) <= 10e-5
				break #breek de for-lus af
			end

		end
		return x
	end
	
	function curt_ingebouwd(a) #een beetje valsspelen om de echte antwoorden te krijgen
		return cbrt(a)
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
begin
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
Schrijf een functie `posmaxi(rij)` die de index van het maximum zoekt in een gegeven Vector/Matrix/Array. Als `rij` op meerdere indices het maximum bereikt, geef dan de kleinste index terug."

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
Schrijf een functie `multifib(M, k)`, waarbij ``M`` een ``2\times n`` matrix is en ``k`` een natuurlijk getal, die als resultaat een ``(2+k)\times n`` matrix geeft waarbij elke rij een Fibonacci rij is. Een Fibonacci rij is een rij getallen waar elk element de som van de twee voorgaande is.
"

# ╔═╡ ed931698-3924-41f1-ba10-f892a7bc120e
function multifib(M, k)

end

# ╔═╡ a197a026-783a-40db-9d92-9d11795dc587
let
	function multifib_corr(M, k)
		n = size(M,2)
		N = zeros(eltype(M), k+2, n)
		
		N[1:2, n] .= M
		
		for j=1:n
			for i=3:k+2
				N[i, j] = N[i-1, j] + N[i-2, j]
			end
		end
		
		return N
		
	end
	
	testcases(multifib, multifib_corr, [let a = rand(1:9), b=rand(a:a+9); ([a, b], 6) end for k=1:7])
	
end

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
#code

# ╔═╡ bfd3d486-2011-4d57-b0d9-b418563c4714
#test je code hier

# ╔═╡ 7a741b0a-f3ff-48c4-9931-f59e5b8456a3
let
	function ruit_corr(n)
		center = (n+1)÷2 #\div<TAB> om ÷ te krijgen, gehele deling
		z = zeros(Int, n,n)
		z[center, 1:n] .= 1
		
		w = 1
		for k=1:(n-1)÷2
			z[k, center-(k-1) : center+(k-1)] .= 1
			z[n+1-k, center-(k-1) : center+(k-1)] .= 1
		end
		return z
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ e5866311-89a3-4262-914c-9efb5e31b89a
md"###### Oefening 17.2 a)
Schrijf een functie `SolveLT(L, b)` die het stelsel ``Lx=b`` oplost waarbij ``L`` een vierkante onderdriehoeksmatrix is."

# ╔═╡ a4294f7b-b52b-4bda-84cc-c1910971e6a2
md"De volgende cel maakt een onderdriehoeksmatrix `L` en een vector `b` aan waarop je kan experimenteren."

# ╔═╡ 7773fc81-c832-4afa-b7d6-997706716f24
begin
	b = rand(3)
	
	L = rand(3,3)
	L[1, 2:3] .= 0
	L[2, 3] = 0
	
	L, b
end

# ╔═╡ 09e5c19e-385d-4354-a9be-269bd9fbd049
md"De volgende cel demonstreert hoe je de ingebouwde solver van Julia kunt gebruiken."

# ╔═╡ a715f3a6-a360-4cd2-93ef-21662be22739
x_solution = L\b #de ingebouwde oplossing, equivalent aan x = L^(-1) * b

# ╔═╡ b8f3080b-b046-42ca-b6b5-29c79fcfb817
md"En de oplossing klopt inderdaad, op een factor ``10^{-16}`` of `...e-16` na, i.e. de machineprecisie."

# ╔═╡ f66dfc98-c7ae-45b2-a9ed-b5fd4239b2d7
L*x_solution - b #we vullen x in in de formule

# ╔═╡ 16343792-a4b8-41c0-b3db-f629ed5be806
md"Voor we onze Solver kunnen schrijven, bekijken we hoe *slicing* precies werkt in Julia. Daarvoor definiëren we eerst een testmatrix `V` en een vector `w`"

# ╔═╡ 8e6acd9a-033d-4f2b-a104-7b20057cefee
V = [1 2 3; 4 5 6; 7 8 9]

# ╔═╡ 2112c056-1c91-43ce-9199-9ae323d5b8d7
 w = [1 2 3]

# ╔═╡ 4c1b4b76-93b1-429b-8d22-a6b53f13ed0e
md"Als we bijvoorbeeld de derde kolom uit `V` halen met slicing, dan krijgen we zoals verwacht een ``3\times 1`` kolomvector."

# ╔═╡ 36bec4cf-070d-4b02-a1eb-c8289bca57b3
V[1:3, 3]

# ╔═╡ cc4df090-d8cb-4e70-8f07-e5e58d49bccd
md"Maar als we de tweede rij uit `V` halen met slicing, dan krijgen we opnieuw een ``3 \times 1`` kolomvector."

# ╔═╡ 909be01f-6e11-4b9d-97b3-b5fa68c085cc
V[2, 1:3]

# ╔═╡ 57e55b37-f26f-403e-bbe9-c42501bfa631
md"Dit gedrag is in sommige gevallen natuurlijk ongewenst. Om toch een rijvector te krijgen, slicen we ook in de eerst index:"

# ╔═╡ 0002d095-e1c5-4d59-a812-85a7ccc41ec1
V[2:2, 1:3]

# ╔═╡ 3d09b315-1f79-47a1-92a1-f9d88930d723
md"Nu we een ``1\times 3`` en een ``3 \times 1`` vector hebben, kunnen we natuurlijk matrixvermenigvuldiging toepassen:"

# ╔═╡ 0a42cfe2-c271-45b4-884b-cc96dd22d943
V[2:2, 1:3] * V[1:3, 3]

# ╔═╡ 8463db13-2be8-4510-bc3a-72fea0242c75
md"Merk op dat het resultaat van de (juiste) vermenigvuldiging een ``1\times 1`` vector is, en dus geen scalair!

Dat betekent dat `w[1] = V[2:2, 1:3] * V[1:3, 3]` een error zou geven: het linkerlid is een scalair, terwijl het rechterlid een vector is! De oplossing is om ook van het linkerlid een vector te maken:"

# ╔═╡ a14b5a59-5589-4928-8647-89a60447a00a
w[1:1] = V[2:2, 1:3] * V[1:3, 3]

# ╔═╡ 59bdf22b-5a85-4ac0-a06e-c8a31bcc922d
w

# ╔═╡ 16972c3e-d3c2-4698-b7c0-4a08de7b33ce
md"Merk ook op dat `V[2, 1:3] * V[1:3, 3]` een error zou geven aangezien je geen ``3 \times 1`` vector met een andere ``3 \times 1`` vector kunt vermenigvuldigen."

# ╔═╡ 8fb74a68-7127-47e0-a625-a8464bff2444
md"Met de voorgaande opmerkingen in het achterhoofd zijn we klaar om de `SolveLT` functie correct op te stellen."

# ╔═╡ 19ea3eeb-26f1-47b5-8125-a14e9d5780ef
function SolveLT(L, b)
	
end

# ╔═╡ 5f59399a-657c-4127-ab12-823bca02ec6f
#vergelijk SolveLT(L, b) met x_solution om na te gaan of je oplossing correct is

# ╔═╡ 5c608409-259e-4044-898e-3af2570c2df1
let
	function SolveLT_corr1(L, b)
		n = size(L,1)
		x = zeros(n, 1)

		x[1] = b[1]/L[1,1]
		for k=2:n
			x[k] = (b[k] - sum(L[k, 1:k-1] .* x[1:k-1]))/L[k,k]
		end
		return x
	end

	function SolveLT_corr2(L, b)
		n = size(L,1)
		x = zeros(n, 1)

		x[1] = b[1]/L[1,1]
		for k=2:n
			#L[k:k, 1:k-1] heeft k:k nodig om 1x(k-1) vorm te behouden
			#L[k, 1:k-1] wordt door Julia naar een (k-1)x1 vector geconverteerd
			x[k:k] = (b[k:k] - L[k:k, 1:k-1] * x[1:k-1])/L[k,k]
			#ook b[k:k] moet een 1x1 matrix blijven, b[k] is namelijk een scalair
			#In corr3 lossen we dit op door .- te gebruiken
		end
		return x
	end
	
	function SolveLT_corr3(L, b)
		n = size(L,1)
		x = zeros(n, 1)

		x[1] = b[1]/L[1,1]
		for k=2:n
			x[k:k] = (b[k] .- (L[k:k, 1:k-1] * x[1:k-1]))/L[k,k]
		end
		return x
	end
	
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ f036f013-9658-4c90-8a11-a20e2f97c8e6
md"###### Oefening 17.2 b)
Schrijf een functie `SolveUT(U, b)` die het stelsel ``Ux=b`` oplost waarbij ``U`` een vierkante bovendriehoeksmatrix is. Om je implementatie te testen kan je opnieuw gebruik maken van de vector `b` en de bovendriehoeksmatrix `U` stellen we gelijk aan de getransponeerde van `L`:"

# ╔═╡ 58a3c497-c6b5-4c74-acfe-2b85902695fe
U = L'

# ╔═╡ 0579056b-c79b-4682-84f0-4aa64a96b58b
function SolveUT(U, b)
	
end

# ╔═╡ 90194342-b00b-494e-a6bc-0220b890ae71
#vergelijk oplossing met model oplossing

# ╔═╡ 4043b0d8-58aa-4a84-83c3-cb70c8a7b517
U\b #modeloplossing

# ╔═╡ a09cd03c-93c1-41b6-9767-507dce6707c2
let
	function SolveLT_corr3(U, b)
		n = size(U,1)
		x = zeros(n, 1)

		x[n] = b[n]/U[n, n]
		for k=n-1:-1:1
			x[k:k] = (b[k] .- (U[k:k, (k+1):n] * x[(k+1):n]))/U[k,k]
		end
		return x
	end
	
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 4b8181c7-a6fb-4655-956b-c7579ce283c4
md"###### Oefening 17.3 a) 
Schrijf een functie `omzetting(t)` die de omzetting doet van graden Celsius (`TC`) naar Fahrenheit (`TF`):

$$TF = \frac{9}{5}TC + 32$$"

# ╔═╡ 0c68d669-9f95-4d82-b05d-babb6a68f465
#definitie

# ╔═╡ 85cd8816-3ef3-421f-9b1b-a53c11b52c51
begin
	omzetting_corr(TC) = 9/5 * TC + 32;
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ a3a513df-f407-4896-984d-c544206d4eab
md"###### Oefening 17.3 b) 
Maak een tabel voor de omzetting van 0°C t.e.m. 100°C."

# ╔═╡ 009120ad-13c0-49fd-9ac0-918c28937044
#tabel

# ╔═╡ 40676469-fc46-4c80-ba3d-396a6cd168ee
begin
	function maaktabel_corr(stapgrootte)
		celcius = 0:stapgrootte:100
		tabel = zeros(Int, length(celcius), 2)
		
		for k=1:length(celcius)
			tabel[k,1] = celcius[k]
			tabel[k,2] = omzetting_corr(celcius[k])
		end
		
		return tabel
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 8843815f-09bd-4cbe-8892-454cf2c036e4
md"###### Oefening 17.3 c) 
Plot de functie `omzetting` van `0` tot `100`."

# ╔═╡ 6e985588-6f26-4da2-a5d1-3b736acc94f0
#plot

# ╔═╡ ac761fcb-9f5a-48e4-92a2-76405fadd4b1
begin
	function plottabel_corr(stapgrootte)
		tabel = maaktabel_corr(stapgrootte)
		plot(tabel[:,1], tabel[:,2], framestyle=:origin)
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ be5b83b7-17f4-42bd-aa1d-2aba45046feb
md"###### Oefening 17.4 a)
Schrijf een functie `plotgauss(start, einde, stap)` die de gausskromme

$$f(x) = e^{-\frac{x^2}{2}}$$

plot tussen het opgegeven interval, i.e. `[start, einde]`, met de opgegeven precisie, i.e. `stap`."

# ╔═╡ e47d8341-d15e-4daf-b48d-396bab9cf094
#functie

# ╔═╡ 0c8f6b43-5af9-4627-9750-56533bc4c7d6
#test

# ╔═╡ d70ed61e-9abd-42b5-a458-56bacfab0627
begin
	function plotgauss_corr(start, einde, stap)
		x = start:stap:einde
		y = @. exp(-x^2/2) #alternatief: exp.(-x.^2/2)
		
		plot(x, y)
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 79ed86dd-224f-4f87-9e1b-f5784b1f2195
md"###### Oefening 17.4 b)
Schrijf een tweede functie `raaklijngauss(a)` die de raaklijn aan de gausskrommen tekent voor opgegeven ``x``-coördinaat ``a``"

# ╔═╡ 3e22c469-9054-4899-808a-b2c417d37859
#definitie

# ╔═╡ e538e97c-a75c-4c7a-9d66-a2feda0d71bd
#test

# ╔═╡ c51d9046-95ef-49d5-a169-65a56036502b
begin
	function raaklijngauss_corr(a)
		
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 66941cc9-cd14-45ef-a821-2bd803cc78da
md"###### Oefening 17.5 
Schrijf een programma `plotcurt(a)` dat de methode van Newton grafisch voorstelt zoals toegepast in oefening 15.7, voor het programma `curt(a)`. Je zult je functie `curt` waarschijnlijk moeten herschrijven als `curt(a, n)` waarbij `n` het aantal stappen is. De nieuwe functie `curt(a, n)` heeft dan als return waarde een lijst van lengte `n`. Merk op dat `curt(a)` en `curt(a,n)` tegelijk kunnen bestaan. Julia kan de twee methoden uit elkaar houden omdat de ene 1 argument aanneemt en de andere twee. We zeggen dat de **functie** `curt` twee **methoden** heeft. In andere programmeertalen noemen we dit ook wel *overloaden* van functies.

Je kan eerst de derde wortel functie plotten met `plot` en er dan de benaderende punten over plotten door `scatter!` te gebruiken."

# ╔═╡ de6cdaf8-cd42-4186-88dd-8a8568b141d4
#definitie

# ╔═╡ 02bd929b-cc0f-4986-a843-a123c9d657c2
#test

# ╔═╡ ae00fcbb-b1dc-46a7-8bf9-cbc3b06b41e1
begin
	function curt_corr(a, n)
		x = zeros(n)
		x[1] = a > 0 ? 0.5 : -0.5
		
		
		f(t) = t^3 - a 
		df(t) = 3*t^2
		
		
		for k=2:n
			x[k] = x[k-1] - f(x[k-1])/df(x[k-1])
		end
		
		return x
	end
	
	function plotcurt_corr(a)
		x = curt_corr(a, 10)
		t = LinRange(min(a-2, minimum(x)), max(a+2, maximum(x)), 100)
		
		plot(t, cbrt.(t), framestyle=:origin)
		scatter!(x, cbrt.(x), series_annotations = text.(1:length(x), :bottom))
	end
	
	#probeer bijvoorbeeld      plotcurt_corr(1000)
		
		
		
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ e37e343a-6161-4ed1-9e13-425afaed4046
md"###### Oefening 17.6 
Definieer de functie

$$s(x) = \frac{x - \sin(x)}{x^3}$$

Bereken achtereenvolgens `s(0.01)`, `s(0.001)`, `s(0.0001)` en `s(0.00001)` en plot vervolgens `s` op het interval ``[-3, 3]``."

# ╔═╡ 8bdcef66-5e66-40ef-9526-12fe58df2254
#definitie

# ╔═╡ 868e5192-1989-4382-ba42-d70c96ce4d55
#berekeningen

# ╔═╡ 3d30ab38-fc39-45b6-a379-b3de6238dd58
#plot

# ╔═╡ 35debdb4-f14a-47ea-8b6c-b1d37026e1f1
begin
	s_corr(x) = (x - sin(x))/x^3
	#plot(LinRange(-3,3,100), s_corr.(LinRange(-3, 3, 100)), framestyle=:origin)
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 200b252f-b222-4e92-b1bc-bd6cfca9d7e9
md"###### Oefening 17.7
Definieer de matrix

$$P = \left[\begin{array}{ccc} 1&2&0\\0&1&2\\2&0&1\end{array}\right]$$

en bereken de eerst 10 machten van `P`. Controleer welke macht van `A` mogelijk is onder de voorwaarde dat alle elementen in deze macht kleiner zijn dan ``10^6``."


# ╔═╡ f612a493-0387-48b5-bce0-4a00bbfd2b87


# ╔═╡ f4681713-285d-4b13-a88d-ee824594bb29


# ╔═╡ da6a8303-dfd7-4e39-8667-99f56037ce17
begin
	P_corr = [1 2 0; 0 1 2; 2 0 1]
	function maxPpower_corr(P)
		p = 1
		while maximum(P^p) < 10^6 && p < 100 #oneindige lus voorkomen
			p += 1
		end
		return p
	end
	md"Open deze cel om de oplossing te bekijken."
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Plots = "~1.21.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "84918055d15b3114ede17ac6a7182f68870c16f7"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.1"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f2202b55d816427cd385a9a4f3ffb226bee80f99"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+0"

[[ColorSchemes]]
deps = ["ColorTypes", "Colors", "FixedPointNumbers", "Random"]
git-tree-sha1 = "9995eb3977fbf67b86d0a0a0508e83017ded03f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.14.0"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "024fe24d83e4a5bf5fc80501a314ce0d1aa35597"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.0"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "727e463cfebd0c7b999bbf3e9e7e16f254b94193"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.34.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[DataAPI]]
git-tree-sha1 = "bec2532f8adb82005476c141ec23e921fc20971b"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.8.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "7d9d316f04214f7efdbb6398d545446e246eff02"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.10"

[[DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[EarCut_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3f3a2501fa7236e9b911e0f7a588c657e822bb6d"
uuid = "5ae413db-bbd1-5e63-b57d-d24a61df00f5"
version = "2.2.3+0"

[[Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b3bfd02e98aedfa5cf885665493c5598c350cd2f"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.2.10+0"

[[FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "Pkg", "Zlib_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "d8a578692e3077ac998b50c0217dfd67f21d1e5f"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.0+0"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "dba1e8614e98949abfa60480b13653813d8f0157"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.5+0"

[[GR]]
deps = ["Base64", "DelimitedFiles", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Printf", "Random", "Serialization", "Sockets", "Test", "UUIDs"]
git-tree-sha1 = "182da592436e287758ded5be6e32c406de3a2e47"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.58.1"

[[GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Pkg", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "ef49a187604f865f4708c90e3f431890724e9012"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.59.0+0"

[[GeometryBasics]]
deps = ["EarCut_jll", "IterTools", "LinearAlgebra", "StaticArrays", "StructArrays", "Tables"]
git-tree-sha1 = "58bcdf5ebc057b085e58d95c138725628dd7453c"
uuid = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
version = "0.4.1"

[[Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "7bf67e9a481712b3dbe9cb3dac852dc4b1162e02"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.68.3+0"

[[Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[HTTP]]
deps = ["Base64", "Dates", "IniFile", "Logging", "MbedTLS", "NetworkOptions", "Sockets", "URIs"]
git-tree-sha1 = "60ed5f1643927479f845b0135bb369b031b541fa"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "0.9.14"

[[HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "8a954fed8ac097d5be04921d595f741115c1b2ad"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+0"

[[IniFile]]
deps = ["Test"]
git-tree-sha1 = "098e4d2c533924c921f9f9847274f2ad89e018b8"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.0"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "642a199af8b68253517b80bd3bfd17eb4e84df6e"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

[[JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d735490ac75c5cb9f1b00d8b5509c11984dc6943"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.0+0"

[[LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[LaTeXStrings]]
git-tree-sha1 = "c7f1c695e06c01b95a67f0cd1d34994f3e7db104"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.2.1"

[[Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "Printf", "Requires"]
git-tree-sha1 = "a4b12a1bd2ebade87891ab7e36fdbce582301a92"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.6"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "761a393aeccd6aa92ec3515e428c26bf99575b3b"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+0"

[[Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "7739f837d6447403596a75d19ed01fd08d6f56bf"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.3.0+3"

[[Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "42b62845d70a619f063a7da093d995ec8e15e778"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+1"

[[Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "340e257aada13f95f98ee352d316c3bed37c8ab9"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.3.0+0"

[[Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "0fb723cd8c45858c22169b2e42269e53271a6df7"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.7"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "Random", "Sockets"]
git-tree-sha1 = "1c38e51c3d08ef2278062ebceade0e46cefc96fe"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.0.3"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "2ca267b08821e86c5ef4376cffed98a46c2cb205"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "bfe47e760d60b82b66b61d2d44128b62e3a369fb"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "0.3.5"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7937eda4681660b4d6aeeecc2f7e1c81c8ee4e2f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+0"

[[OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "15003dcb7d8db3c6c857fda14891a539a8f2705a"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.10+0"

[[Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PCRE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b2a7af664e098055a7529ad1a900ded962bca488"
uuid = "2f80f16e-611a-54ab-bc61-aa92de5b98fc"
version = "8.44.0+0"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "438d35d2d95ae2c5e8780b330592b6de8494e779"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.0.3"

[[Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlotThemes]]
deps = ["PlotUtils", "Requires", "Statistics"]
git-tree-sha1 = "a3a964ce9dc7898193536002a6dd892b1b5a6f1d"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "2.0.1"

[[PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "9ff1c70190c1c30aebca35dc489f7411b256cd23"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.0.13"

[[Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "GeometryBasics", "JSON", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "PlotThemes", "PlotUtils", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs"]
git-tree-sha1 = "2dbafeadadcf7dadff20cd60046bba416b4912be"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.21.3"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00cfd92944ca9c760982747e9a1d0d5d86ab1e5a"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.2.2"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "ad368663a5e20dbb8d6dc2fddeefe4dae0781ae8"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+0"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[RecipesBase]]
git-tree-sha1 = "44a75aa7a527910ee3d1751d1f0e4148698add9e"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.1.2"

[[RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase"]
git-tree-sha1 = "d4491becdc53580c6dadb0f6249f90caae888554"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.4.0"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "4036a3bd08ac7e968e27c203d45f5fff15020621"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.1.3"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Scratch]]
deps = ["Dates"]
git-tree-sha1 = "0b4b7f1393cff97c33891da2a0bf69c6ed241fda"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.1.0"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "3240808c6d463ac46f1c1cd7638375cd22abbccb"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.2.12"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
git-tree-sha1 = "1958272568dc176a1d881acb797beb909c785510"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.0.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8cbbc098554648c84f79a463c9ff0fd277144b6c"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.10"

[[StructArrays]]
deps = ["Adapt", "DataAPI", "StaticArrays", "Tables"]
git-tree-sha1 = "1700b86ad59348c0f9f68ddc95117071f947072d"
uuid = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
version = "0.6.1"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "d0c690d37c73aeb5ca063056283fde5585a41710"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.5.0"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[URIs]]
git-tree-sha1 = "97bbe755a53fe859669cd907f2d96aee8d2c1355"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.3.0"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "3e61f0b86f90dacb0bc0e73a0c5a83f6a8636e23"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.19.0+0"

[[Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll"]
git-tree-sha1 = "2839f1c1296940218e35df0bbb220f2a79686670"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.18.0+4"

[[XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "1acf5bdf07aa0907e0a37d3718bb88d4b687b74a"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.9.12+0"

[[XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "cc4bf3fdde8b7e3e9fa0351bdeedba1cf3b7f6e6"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.0+0"

[[libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "c45f4e40e7aafe9d086379e5578947ec8b95a8fb"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+0"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"

[[x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "ece2350174195bb31de1a63bea3a41ae1aa593b6"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "0.9.1+5"
"""

# ╔═╡ Cell order:
# ╟─3518a9c4-1e79-4614-9a4e-6a8eb1989a5c
# ╟─83324317-bd52-4163-a07a-f0b8fc589e30
# ╠═5e7323ad-e66d-4f26-be3d-eb956c964761
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
# ╠═8abe9956-cd72-4200-aee1-1d7257bb0ae8
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
# ╠═ed931698-3924-41f1-ba10-f892a7bc120e
# ╟─a197a026-783a-40db-9d92-9d11795dc587
# ╟─5d92b351-69aa-4cea-9534-09fe44a6d3d2
# ╠═762be3b6-0be2-4368-8e51-d696357ff6cc
# ╟─070d6a89-112b-4e80-b142-ca7c567628b8
# ╟─d754bd1a-3cea-408a-99d1-1525f574847f
# ╠═52207a3e-7894-4606-afd6-3c757cdf6646
# ╟─38a65bfd-00a7-4aad-b924-9eaca5132939
# ╟─c569b18f-b902-4d5d-abe3-5ce54f1316e4
# ╟─008339f1-267e-4d08-bf61-c5f43633e1d5
# ╠═aabab6cc-383d-4abd-8a8b-83a98e9c6705
# ╠═bfd3d486-2011-4d57-b0d9-b418563c4714
# ╟─7a741b0a-f3ff-48c4-9931-f59e5b8456a3
# ╟─e5866311-89a3-4262-914c-9efb5e31b89a
# ╟─a4294f7b-b52b-4bda-84cc-c1910971e6a2
# ╠═7773fc81-c832-4afa-b7d6-997706716f24
# ╟─09e5c19e-385d-4354-a9be-269bd9fbd049
# ╠═a715f3a6-a360-4cd2-93ef-21662be22739
# ╟─b8f3080b-b046-42ca-b6b5-29c79fcfb817
# ╠═f66dfc98-c7ae-45b2-a9ed-b5fd4239b2d7
# ╟─16343792-a4b8-41c0-b3db-f629ed5be806
# ╠═8e6acd9a-033d-4f2b-a104-7b20057cefee
# ╠═2112c056-1c91-43ce-9199-9ae323d5b8d7
# ╟─4c1b4b76-93b1-429b-8d22-a6b53f13ed0e
# ╠═36bec4cf-070d-4b02-a1eb-c8289bca57b3
# ╟─cc4df090-d8cb-4e70-8f07-e5e58d49bccd
# ╠═909be01f-6e11-4b9d-97b3-b5fa68c085cc
# ╟─57e55b37-f26f-403e-bbe9-c42501bfa631
# ╠═0002d095-e1c5-4d59-a812-85a7ccc41ec1
# ╟─3d09b315-1f79-47a1-92a1-f9d88930d723
# ╠═0a42cfe2-c271-45b4-884b-cc96dd22d943
# ╟─8463db13-2be8-4510-bc3a-72fea0242c75
# ╠═a14b5a59-5589-4928-8647-89a60447a00a
# ╠═59bdf22b-5a85-4ac0-a06e-c8a31bcc922d
# ╟─16972c3e-d3c2-4698-b7c0-4a08de7b33ce
# ╟─8fb74a68-7127-47e0-a625-a8464bff2444
# ╠═19ea3eeb-26f1-47b5-8125-a14e9d5780ef
# ╠═5f59399a-657c-4127-ab12-823bca02ec6f
# ╟─5c608409-259e-4044-898e-3af2570c2df1
# ╟─f036f013-9658-4c90-8a11-a20e2f97c8e6
# ╠═58a3c497-c6b5-4c74-acfe-2b85902695fe
# ╠═0579056b-c79b-4682-84f0-4aa64a96b58b
# ╠═90194342-b00b-494e-a6bc-0220b890ae71
# ╠═4043b0d8-58aa-4a84-83c3-cb70c8a7b517
# ╟─a09cd03c-93c1-41b6-9767-507dce6707c2
# ╟─4b8181c7-a6fb-4655-956b-c7579ce283c4
# ╠═0c68d669-9f95-4d82-b05d-babb6a68f465
# ╟─85cd8816-3ef3-421f-9b1b-a53c11b52c51
# ╟─a3a513df-f407-4896-984d-c544206d4eab
# ╠═009120ad-13c0-49fd-9ac0-918c28937044
# ╟─40676469-fc46-4c80-ba3d-396a6cd168ee
# ╠═8843815f-09bd-4cbe-8892-454cf2c036e4
# ╠═6e985588-6f26-4da2-a5d1-3b736acc94f0
# ╟─ac761fcb-9f5a-48e4-92a2-76405fadd4b1
# ╟─be5b83b7-17f4-42bd-aa1d-2aba45046feb
# ╠═e47d8341-d15e-4daf-b48d-396bab9cf094
# ╠═0c8f6b43-5af9-4627-9750-56533bc4c7d6
# ╟─d70ed61e-9abd-42b5-a458-56bacfab0627
# ╟─79ed86dd-224f-4f87-9e1b-f5784b1f2195
# ╠═3e22c469-9054-4899-808a-b2c417d37859
# ╠═e538e97c-a75c-4c7a-9d66-a2feda0d71bd
# ╟─c51d9046-95ef-49d5-a169-65a56036502b
# ╟─66941cc9-cd14-45ef-a821-2bd803cc78da
# ╠═de6cdaf8-cd42-4186-88dd-8a8568b141d4
# ╠═02bd929b-cc0f-4986-a843-a123c9d657c2
# ╟─ae00fcbb-b1dc-46a7-8bf9-cbc3b06b41e1
# ╟─e37e343a-6161-4ed1-9e13-425afaed4046
# ╠═8bdcef66-5e66-40ef-9526-12fe58df2254
# ╠═868e5192-1989-4382-ba42-d70c96ce4d55
# ╠═3d30ab38-fc39-45b6-a379-b3de6238dd58
# ╟─35debdb4-f14a-47ea-8b6c-b1d37026e1f1
# ╟─200b252f-b222-4e92-b1bc-bd6cfca9d7e9
# ╠═f612a493-0387-48b5-bce0-4a00bbfd2b87
# ╠═f4681713-285d-4b13-a88d-ee824594bb29
# ╟─da6a8303-dfd7-4e39-8667-99f56037ce17
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
