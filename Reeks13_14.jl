### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d6788779-fc9f-431c-b247-6f9da302fc00
using Pkg #de Pkg package stelt ons in staat om binnen Julia packages te installeren

# ╔═╡ 22410d92-2b7e-4a3f-8190-79b5562b4289
using Plots #Julia heeft een aantal Plot packages, voorlopig lijkt "Plots" de interessantste, maar "Makie" is ook interessant. Plots is wel berucht om zijn trage opstarttijd.

# ╔═╡ 789d0bc6-235d-433f-be4d-f9200fb94a71
using LinearAlgebra

# ╔═╡ dacbdbec-a43c-47bc-9f61-b2da6cecd3d6
using BenchmarkTools #je weet intussen wel wat je moet doen als dit een error geeft

# ╔═╡ 065f9b00-ce70-11eb-1ee1-5d39cf5e39fc
md"# Oefeningen Julia I"

# ╔═╡ c5d21e48-12e1-49e0-b1ac-1695c18fc7f2
md"## Reeks 13
Pluto notebooks laat je maar toe om 1 statement per cel te schrijven:
"

# ╔═╡ 47a2c712-dc44-4ff4-bdf6-0d78178812cb
md"#### Variabelen en elementaire operaties"

# ╔═╡ b868460c-f229-4d0a-ac98-42e76cad1a1b
var1 = 1

# ╔═╡ 301dfceb-77d6-4c35-b62a-ffbdb63133d7
md"Als je meerdere expressies in een cel probeert te schrijven, krijg je een error:"

# ╔═╡ 250be0f8-db4b-48c5-8d96-f64acfd012d6
var2 = 3
var3 = 4

# ╔═╡ 4a0c5464-12aa-4e44-bdcc-bc0facab94a7
md"In het error bericht suggereert ons twee mogelijke oplossingen, waarvan de tweede het interessantste is. Als we twee (of meer) statements groeperen binnen een `begin ... end` blok, dan telt dat voor Pluto slechts als 1 expressie:"

# ╔═╡ 278ab1cf-9935-4eb5-afdf-65d98295491b
begin
	var4 = 2
	var5 = 2.0
	var6 = "VUB"
end

# ╔═╡ e39d5f41-5df8-43d3-bda0-990860dac893
md"Een `begin` blok heeft als return-waarde de waarde van de laatste expressie binnen dat blok, in dit geval dus de *waarde van* `var6`. Bovendien introduceert een `begin` block geen locale scope wat betekent dat `var4`, `var5` en `var6` in heel de notebook kunnen gebruikt worden:"

# ╔═╡ e666713a-e983-4435-949e-15fda6d89da0
var4 + var5

# ╔═╡ 5a96d25f-3a80-484c-89eb-0a5d7cd31b95
md"Als je niet wilt dat de globale scope van je notebook vervuild wordt met tijdelijke variabelen, met soms heel algemene namen, dan kun je een `let` blok gebruiken in de plaats van een `begin` blok. Het volgende `let` blok wordt gebruikt om de inhoud van een cilinder te berekenen, met de nodige tussenstappen voor de duidelijkheid. Dit `let` blok heeft als return-waarde de *waarde van* `inhoud_cilinder`, maar de variabele `inhoud_cilinder` is niet zichtbaar in de globale scope:"

# ╔═╡ 2450a720-7ba4-4fec-83a9-3f4cfb4fdc78
let
	r = 2
	h = 4
	
	opp_grondvlak = 2*π*r #je kan het symbool π tevoorschijn toveren door \pi<TAB> te typen. Gewoon het woord pi zou ook werken.
	inhoud_cilinder = opp_grondvlak * h
end

# ╔═╡ 31aa20a2-cf79-4c04-af18-62ce498b94da
inhoud_cilinder #zal een error geven

# ╔═╡ 1c6f70a5-f39e-4667-ae70-d545f138720b
md"Verder is het belangrijk om op te merken dat variabelen types hebben, die je kan nagaan met de ingebouwde functie `typeof`:"

# ╔═╡ a25aeab8-e9ba-41bd-b0d1-f2754166d2a3
typeof(var4) #64 bit integer (geheel getal)

# ╔═╡ f59c258f-21e8-43ac-ad5c-7eec51da6a57
typeof(var5) #64 bit floating point (getal met decimalen)

# ╔═╡ 14bfc8ae-c5b8-43d4-a628-595693dd2832
typeof(var6)

# ╔═╡ 8c703f1c-43ae-407a-b62f-d1999ff34caa
md"Merk op dat als je `var4` en `var5` optelt, je een `Float` krijgt."

# ╔═╡ bfcab42a-1342-476c-9087-a0c7d7c2f492
typeof(var4 + var5)

# ╔═╡ c337d274-abe1-4cfe-ac87-294b80075330
md"Welk type is `var4 / 2`?"

# ╔═╡ 4d3420dd-26ce-4d0e-af5b-50b1e6b87c5a
#test

# ╔═╡ 76a41e87-64df-4d07-9516-7ffd4796b258
md"Om een gehele deling uit te voeren tussen twee `Int` waarden, gebruik je `÷` (\div<TAB>)."

# ╔═╡ a111340d-c2b1-4c38-be08-7de3a60488ae
4÷2

# ╔═╡ ac737b66-2c3f-45bb-bd75-22053e9e5802
var4÷3

# ╔═╡ 7218f1f9-79cd-4f09-9062-4e4067ab8907
md"Om de rest van de gehele deling te verkrijgen gebruik je %"

# ╔═╡ 023f4cec-a9d8-4917-bd3a-82671810b7dc
8%3

# ╔═╡ 3ca36760-70e7-420c-99af-fa5be4f05e56
md"#### Lussen en control flow
De volgende voorbeelden illustreren kort `if` statements, `for` loops en `while` loops."

# ╔═╡ 41dc1743-ec11-49f1-b9c6-adc3aa472cbd
if π == 3
	"Ingenieur"
elseif sqrt(2) == 1.4
	"Fysicus"
else
	"Wiskundige"
end

# ╔═╡ 4f940fb4-137f-4b04-bb0d-920aa2c2ec74
let 
	t = 0
	for i=4:7
		t = t + i
	end
	t
end

# ╔═╡ d3c4b019-b840-44ad-abe3-eeef6c1442f5
let
	t = 3.0
	while t < 33
		t += π
	end
	t
end

# ╔═╡ 08b75692-7668-4871-ae68-27e0f3ade957
md"#### Functies
In Julia zijn er twee manieren om functies te definiëren."

# ╔═╡ 94c4d137-cf34-4481-9a9d-0747e9a0d963
f_kort(x) = 3*x^2 - 2*x + 3 #compact, voor kleine functies

# ╔═╡ 753d2408-7c51-41dc-8c4c-eb7e11f0d8bb
function f_lang(x)
	if x > 0
		return 2*x^2 + exp(x)
	else
		sin(x) + exp(x)
	end
end

# ╔═╡ 2e821c0e-39fd-4bd4-a5bc-b746057581aa
md"In de definitie van `f_lang` gebruiken we slechts 1 keer return om te illustreren dat het gebruik van het *keyword* `return` optioneel is. Indien er geen return statement in een functie staat, geeft Julia als return-waarde de laatste expressie uit de functie, in dit geval `sin(x) + exp(x)`"

# ╔═╡ 0c226ac3-b287-44f7-b8b9-dfdee33f1664
md"#### Vectoren, Matrices en Arrays
In Julia is een Vector een ``N\times 1`` Matrix, en een Matrix is een ``N\times M`` Array. 

Een Array kan willekeurige afmetingen ``N_1\times N_2\times \ldots \times N_n`` hebben. Een 3D ``N_1 \times N_2 \times N_3`` Array bijvoorbeeld, kun je je voorstellen als ``N_3`` matrices van afmetingen ``N_1 \times N_2`` op elkaar gestapeld. De begrippen Vector en Matrix zijn gewoon bijnamen, aliassen, voor een 1D resp. 2D Array.

Je zult deze 3 begrippen vaak door elkaar horen, maar weet dat ze onder de motorkap eigenlijk allemaal gewoon Arrays zijn van verschillende dimensies.

De volgende voorbeelden definiëren een aantal matrices en vectoren."

# ╔═╡ 33d6b3e1-15aa-486a-9430-9cf50b770f89
v1 = [1, 2, 3, 4]

# ╔═╡ 5cacc4bf-5d33-4e34-a6cc-c29d4099c7a7
typeof(v1)

# ╔═╡ a3c7c7db-7ad5-4f90-a13e-d8c645091c56
v2 = [2 3 1 4]

# ╔═╡ a1b3e668-e1e9-443f-90e9-2dc48bb78808
typeof(v2)

# ╔═╡ 8366c38f-8bcd-474e-a126-d03d91874a05
v3 = [-4; -8; 5; 7]

# ╔═╡ 75e789f0-080d-47ab-9814-c42e544c8be5
typeof(v3)

# ╔═╡ cfeebf19-6524-4ab5-a785-59821858c154
M = [1 2 3 4; 5 6 7 8]

# ╔═╡ a6e03bc3-5dbc-4dca-9a99-94d6c76e86af
typeof(M)

# ╔═╡ 8c4f7bf5-3425-4d65-a074-252eeaffec6b
md"Met de functie `size` kunnen we de grootte van een Array bepalen. De return-waarde is van het type `Tuple`."

# ╔═╡ 2873b7ed-730d-413d-be83-b5ac87890a59
size(v1)

# ╔═╡ be2a71b3-fdd8-4418-989c-c9fa45fad226
size(v2)

# ╔═╡ 5b04b4bb-d8dd-437b-bf29-d0d38ad8e9c5
size(M)

# ╔═╡ 1bd9328e-52a1-4be6-a5c8-fe579f067f45
size(M, 2) #aantal rijen van M

# ╔═╡ d25571ac-f9b7-486e-a24d-ad3c66d971f1
md"Met de functie `length` kunnen we het aantal elementen in een Array berekenen. Merk op dat voor een `Vector` geldt dat

`length(v) = size(v, 1)`

terwijl voor een `Matrix` geldt dat

`length(M) = size(M, 1) * size(M, 2)`"

# ╔═╡ 0b3c812a-a8bf-48ba-96a7-694647cdd3c9
md"Natuurlijk kunnen we matrices en vectoren met elkaar vermenigvuldigen"

# ╔═╡ 46f841eb-b35e-4095-b9eb-61538aa56ff8
M*v1

# ╔═╡ 7036709e-8cd3-43c8-9125-38a7aaecce19
M*v3

# ╔═╡ b080a19d-8193-48ec-98c6-a5adce99f689
M*v2 #error foute dimensies!

# ╔═╡ 26a802e8-8df6-46e4-b087-b3db84645eed
M*v2' #we transponeren v2

# ╔═╡ 500826c8-7089-42f6-8f40-8e3aa01de986
v2 * v1 #een inproduct

# ╔═╡ 7b75f643-9eff-436e-8745-4479b1861ea7
md"Soms willen we vectoren puntsgewijs vermenigvuldigen. Dat kan met de `.*` operator."

# ╔═╡ de7c2a28-25b3-49d4-a848-6eced7a4afc2
v1 .* v3

# ╔═╡ 0f57884d-9ebe-4354-a133-f4b9266565a5
md"Probeer ook twee vectoren puntsgewijs te delen en te exponentiëren, i.e. `vector1` puntsgewijs tot de macht `vector2`."

# ╔═╡ 9d1139bd-3c58-4e5e-a09f-e88cc02a3a28
#probeer zelf

# ╔═╡ 16a4cb60-3cfa-4f50-b0a1-f782252b1556
md"Dit werkt natuurlijk ook met matrices. Probeer `M` puntsgewijs met zichzelf te vermenigvuldigen."

# ╔═╡ cd1aa28d-ecc4-47cc-8d0c-074e68f699b3
#puntsgewijs

# ╔═╡ cf62badc-4828-474e-9be3-69f46caad71f
md"Matrices en vectoren indexeren we met vierkante haakjes. Om het ``i``de element van de ``3\times 1`` Vector `w1` op te vragen, gebruiken we `w1[i]`"

# ╔═╡ 6a64f91d-fc6e-4e2b-89fe-29888d6595c5
w1 = [7, 8, 9]

# ╔═╡ 07a585b7-65dd-4209-85e4-8e3442ac0160
#vraag het tweede element van w1 op in deze cel

# ╔═╡ 6ab7e445-beb5-4c09-99b2-aed428017b59
md"Om het element op positie ``ij`` in een `M\times N`` matrix `U` op te vragen, gebruiken we `U[i,j]`:"

# ╔═╡ c9ca7dcb-9e80-4d91-bf92-cc23b2e4558f
U = [1 2 3 4; 5 6 7 8; -9 -8 -7 -6; -5 -4 -3 -2]

# ╔═╡ 8c286d60-1a84-4411-82ca-59ed605a40c3
#Bepaal het element op positie 3,4 in U

# ╔═╡ 6a095ac0-ef7f-484c-95ce-70d05a954598
md"Om het element op positie ``j`` op te vragen in een ``1\times N`` rijvector `w2`, zouden we eigenlijk `w2[1, j]` moeten schrijven aangezien `w2` door Julia als Matrix beschouwd wordt. In dit speciale geval werkt `w2[i]` ook."

# ╔═╡ ee01eda9-f9c2-472b-b7c0-6e2268e6b6d9
w2 = [-2 8 9]

# ╔═╡ 89e98a65-2190-47ec-9291-78152254bd15
#bepaal het derde element van w2

# ╔═╡ b6e1919e-67f3-4111-8a22-7a8e5f3391e3
md"#### Slicing
Vaak zijn we gegeven een matrix `W` geïnteresseerd in een bepaalde submatrix van `W`. In Julia kunnen we de elementen van kolom `k1` t.e.m. `k2` en van rij `r1` t.e.m. `r2` opvragen via de uitdrukking `W[r1:r2, k1:k2]`.

Voer nu de matrix `W` in:

$$W = \left[\begin{array}{cccc} 2&3&-3&2\\1&1&-1&-1\\6&7&8&9\\-4&2&2&-4\end{array}\right]$$"

# ╔═╡ 2f44e545-1c6d-40de-a672-5b74ee6668c1
W = [2 3 -3 2; 1 1 -1 -1; 6 7 8 9; -4 2 2 -4]

# ╔═╡ 4ee457f7-363c-4e3f-9672-06cbc0c5149e
md"Bepaal de submatrix van rij 1 t.e.m rij 3 en van kolom 3 t.e.m. kolom 4."

# ╔═╡ 88ef2a42-d141-442a-9a2c-dc8101488ea0
#submatrix

# ╔═╡ 51b03a13-3577-4838-8786-cbeecd2031be
md"Let wel op de volgende regels: (als je `W` nog niet correct hebt ingevoerd, zul je hier errors te zien krijgen)"

# ╔═╡ 6a30d20e-3b97-45c3-95e1-c475e645b716
W[2,2] #een scalair

# ╔═╡ abf65b18-3d4d-4c3a-ae67-d9493ff38845
W[2:2, 2:2] #een 1x1 matrix

# ╔═╡ 95b14d2c-d4d6-416f-a419-795e617b7996
W[2:2, 2] #een 1x1 vector

# ╔═╡ 3a812e19-acf8-4b56-ae8a-371d1feb456a
W[2, 2:2] #een 1x1 vector

# ╔═╡ 4b96e09f-e9b0-4551-816d-d930b497deba
md"Merk op dat als we een rijvector uit de matrix `W` *slicen*, we een kolomvector krijgen. Met andere woorden: we verwachten een ``1 \times n`` `Matrix`, maar we krijgen een ``n \times 1`` `Vector`"

# ╔═╡ 614a2f14-6a62-4255-8495-f6987dd7ead0
W[1, 2:4] #een 3x1 Vector

# ╔═╡ c0fbdac3-c250-4029-9ab6-70d8ea30aaa6
md"Dat komt omdat Julia de slice voor ons vereenvoudigt. Als we willen dat de vorm behouden blijft, moeten we het volgende schrijven:"

# ╔═╡ d956b439-dee4-4b51-a7b0-98fccd7bbf99
W[1:1, 2:4] #een 1x3 Matrix

# ╔═╡ 69d81a78-e94d-4bed-9a7b-b634041736a9
md"En ten slotte hebben we de volgende syntactische suiker"

# ╔═╡ a9f37ee3-45e7-4ae5-bdc6-449d871bead6
W[3, :] #de hele derde rij

# ╔═╡ 3fef6aca-e4f1-4f15-b013-4c42849da952
W[:, 1] #de hele eerste kolom

# ╔═╡ f5a5b028-6ed8-4651-8c5b-fc3eedef5d64
W[1:end-1, 1] #de eerste kolom, zonder het laatste element

# ╔═╡ bfbfc377-0f11-4f86-8f30-1737f98b82c8
md"#### Plotten
De `plot` functie is geen onderdeel van de Julia standaard bibliotheek. Daarom moeten we de `Plots` package installeren en importeren. Daarom importeren we eerst de `Pkg` package. Dat is de package om andere packages mee te installeren, zoals Internet Explorer de browser is waarmee je andere browsers installeert."

# ╔═╡ 96bb54fd-cced-42ae-bc9a-2935617ffe48
md"Voer de code in de onderstaande cel uit om `Plots` te installeren. In de daaropvolgende cel proberen we `Plots` al te importeren. Merk op dat dit een error oplevert. Merk ook op dat de error ons de juiste oplossing suggereert."

# ╔═╡ a2bddf16-b6c3-4b09-9729-1ec6e7b1f073
#Pkg.add("Plots")

# ╔═╡ 9b29d263-6ace-4025-8b93-fa7ea9e02bb1
md"Laten we een eerste plot maken. De functie `plot` vereist als invoer 2 `Vectoren` van dezelfde lengte."

# ╔═╡ 9a710788-4e90-4cee-b095-7c9b8e0e6462
let
	x = [0, 1, 2, 3, 4]
	y = [3, 2, 3, 4, 1]
	plot(x, y)
end

# ╔═╡ 7c581841-0ac6-4a42-8e3d-ecadfd325064
md"Julia biedt ons aantal handige `range` objecten aan die ons het plotten vergemakkelijken."

# ╔═╡ e1dbf1f6-864e-46c9-8f0e-84a335c8a40f
let 
	x = 0:5
	y = x.^2 .+ 3*x .- 2 #let op de dot syntax!
	plot(x,y)
end

# ╔═╡ 81dace0a-1bfd-48fb-9cb0-4f38fb3e843b
md"De functie in het vorige voorbeeld ziet er niet zo glad uit. Probeer de functie gladder te krijgen door `x` *fijnmaziger* te maken. Vervang `0:5` een `range` object van de vorm `BEGIN:STAPGROOTTE:EINDE`."

# ╔═╡ e8a26313-964d-4ed7-a58a-4583c1f82a87
md"Technisch detail: hoewel `0:5` zich gedraagt als een `Vector`, is het geen `Vector`. In de plaats van een `Vector`  `v = [0, 1, 2, 3, 4, 5]` aan te maken, bespaart Julia geheugen door enkel de eerste waarde, de laatste waarde en de stapgrootte te onthouden. Als je dan het ``i``de element van `0:5` opvraagt, berekent Julia dat *on the fly*. Kun je hier een formule voor opstellen?"

# ╔═╡ 4c6bf641-8695-4f32-aa4c-72c07ad463d6
function myRange(start, stop, stapgrootte, i)
	return 0 #geef het i-de element terug van de range start:stapgrootte:stop
	#vergelijk jouw oplossing met (start:stapgrootte:stop)[i]
end

# ╔═╡ 5ffead21-503c-4caf-b5f4-895657ea7243
#test je functie hier

# ╔═╡ 8596436c-1d61-48f3-935e-30f5a934797f
md"In het zeldzame geval dat je een `range` toch wilt omzetten in een geheugenconsummerende `Vector`, dan kan dat via de functie `collect`:"

# ╔═╡ a9b52560-bea6-4707-a8a5-8453f3b44aec
collect(0:5)

# ╔═╡ 645ec134-ce39-40b6-840b-e256331c1aec
collect(0:0.1:1)

# ╔═╡ 98bd5286-58a2-4750-8b39-f2d0c221b074
md"In Julia zijn er nog twee andere manieren om een `range` aan te maken, die enkel verschillen in performantie, gebruiksgemak en manier waarop ze worden getoond in de output:"

# ╔═╡ b2b05431-5750-437f-bf33-802821c0a21a
range(0,1,length=11)

# ╔═╡ 56dad723-0afb-4d79-bb03-5aea56853002
LinRange(0,1,11)

# ╔═╡ d80c5aa0-6635-4de4-aab1-22e2ff7a98ab
md"Met deze nieuwe kennis zijn we in staat om betere plots te maken. Het volgende voorbeeld toont 3 manieren om exact dezelfde plot te genereren, en plot ze over elkaar. Merk op dat om te plot te genereren, we de functie `plot` gebruiken, maar om de huige plot aan te passen, we de functie `plot!` gebruiken.

Om beter in te zien dat de drie plots wel degelijk gelijk zijn, kan je de `+3` op het einde van de definities van `y1`, `y2` en `y3` bijvoorbeeld vervangen door `+2.9`, `+3` en `+3.1`."

# ╔═╡ 3c660b08-d878-4e90-a0cd-7c9a0e08106d
let
	x = LinRange(-1, 1, 100) 
	y1 = 2*x.^3 - 2*x .+ 3 #elementsgewijze bewerkingen vereisen veel punten
	
	y2 = @. 2*x^3 - 2*x + 3 #het @. macro neemt ons die zorgen uit handen
	
	y3 = [2*x[i]^3 - 2*x[i] + 3 for i=1:length(x)] #alternatieve aanpak
	
	plot(x, y1)
	plot!(x, y2)
	plot!(x, y3)
end

# ╔═╡ ea440d78-1d5f-4455-9cca-73d6ae6690ad
md"In het volgende voorbeeld maken we gebruik van zelfgedefinieerde functies in plots. Pas de code aan zodat je dezelfde plot krijgt als in het vorige voorbeeld."

# ╔═╡ 11450cdf-0a75-435b-9cbd-0ede916d2939
let 
	x = LinRange(-1, 1, 100)
	
	f(t) = t^6 - t 
	
	y = [f(x[i]) for i=1:length(x)]
	
	#of
	y_alternatief = [f(x_i) for x_i in x]
	
	plot(x, y)
end

# ╔═╡ e3acd775-2792-448f-9d3c-70785282945e
md"De definitie van `y` in het vorige voorbeeld voelt nog steeds wat stroef aan, het zou veel eleganter zijn als we gewoon `y=f(x)` zouden kunnen schrijven:"

# ╔═╡ b94dc16e-4230-43d4-acee-9ba9eb3b5cd6
let 
	x = LinRange(-1, 1, 100)
	f(t) = t^6 - t
	
	y = f(x)

	plot(x, y)
end

# ╔═╡ b5f7417b-e51a-46de-b7c0-5de3448d84ee
md"Maar dat geeft een error omdat we een `Vector`-achtig object zoals `x` niet tot de zesde macht kunnen verheffen. Een optie is om de functie `f` te definiëren zodat hij rekening houdt met het feit dat zijn argument, `t`, een `Vector` kan zijn."

# ╔═╡ 79e6acae-3f81-4110-9d3c-ecc3ebdf8fb7
let 
	x = LinRange(-1, 1, 100)
	f(t) = @. t^6 - t
	
	y = f(x)

	plot(x, y)
end

# ╔═╡ 2d3ceaf9-9ce2-49b8-ba50-96fbc3d4314f
md"Dat werkt, maar is opnieuw niet erg handig. Beschouw bijvoorbeeld de volgende, gecompliceerdere functie:

$$f(t) = \left\{\begin{array}{ll} t^6 - t &\text{als } t ≤ 0\\ 3t^2 - t & \text{als } t > 0\end{array}\right.$$

Hier brengt Julia's syntactische suiker opnieuw redding. In Julia kan je *elke* functie `f` *vectoriseren* met behulp van deze *dot-syntax*: `f.(x)`. Het volgende voorbeeld demonstreert dit."

# ╔═╡ 7c9b266c-4cae-48dc-aab1-bfb74560bcb1
let 
	x = LinRange(-1, 1, 100)
	
	function f(t)
		if t <= 0
			return t^6 - t
		else
			return 3t^2 - t
		end
	end
	
	y = f.(x) 
	
	y_alternatief = [f(x_i) for x_i in x] #minder elegant en duidelijk
	
	plot(x, y)
end

# ╔═╡ 11f2d5e0-c5a7-411b-9a01-8786b99f8e56
md"Maak in de volgende cel een grafiek van de volgende drie plots over elkaar

$$f(t) = \left\{\begin{array}{ll} \sin(2πt) + 1 &\text{als } t ≤ 0\\ \cos(4πt) & \text{als } t > 0\end{array}\right.$$

$$g(t) = 3e^{|\sin(2πt)|} - 6$$

$$h(t) = \max\{\sqrt{|t|}, \tan(t)\}$$

Je kan de formules bijna letterlijk vertalen naar Julia, enkel om ``e^t`` te berekenen moet je `exp(t)` gebruiken."

# ╔═╡ 51645a3c-51b8-47a7-b2dc-2bcdd356ca37
#plot hier

# ╔═╡ 9cd2914a-e540-4131-8606-3533aaa16887
md"Ten slotte kunnen we aan de functie `plot` *keyword arguments* meegeven om de layout aan te passen. "

# ╔═╡ 72f7d7a6-55ce-4ba2-97d3-99bae26f54b1
begin
	t = range(-2*π, 2*π, length=1000)
	
	plot(t, sin.(t) .* cos.(t), framestyle=:origin, ylims = (-2, 2), color=:green)
end
#er zijn veel meer keyword argumenten die je kan terugvinden in de Julia Plots documentatie

# ╔═╡ 7b766daf-f703-4dfd-a09c-c7439078574a
md"## Reeks 14
In deze reeks bekijken we een aantal voorbeelden van veelvoorkomende taken in Julia. We bekijken ook de syntax van Julia in meer detail.
"

# ╔═╡ 2ea91520-caa3-40ae-bbd4-8e122d253528
md"### Basisfunctionaliteit"

# ╔═╡ 0269c3bc-0c2e-4095-ac9b-af62429f74ec
md"#### Elementaire functies en terminal output
Het volgende programma demonstreert een aantal elementaire functies in Julia."

# ╔═╡ e4a99736-a706-489c-99a3-fc50b04d73f1
sqrt(25)

# ╔═╡ b0dbedbb-993a-4406-ade0-dbe3d83eb626
cbrt(64)

# ╔═╡ 0398cfd3-4b37-4c16-a2bd-de8764ec4dec
exp(10)

# ╔═╡ 3dbb2f16-9639-4242-9777-4152d65b87cf
log2(64)

# ╔═╡ 875ad7bc-edfe-4db4-8a55-524df9cbefc8
log10(1000)

# ╔═╡ 14d9a28d-fb1e-4ded-acd9-9e9ad92396b4
log(exp(4))

# ╔═╡ 7c21e16a-cd54-4747-8884-ad69c3696734
conj(8 - 5im)

# ╔═╡ 5e623855-b9fe-42bc-84b1-49406114b0ef
abs(3 + 4im)

# ╔═╡ 680fb1fa-ac22-4567-8267-7087952a15c9
angle(3 + 4im)

# ╔═╡ e66a28d7-0782-4734-8aaa-c8bd458b4cb0
abs(3 + 4im) * exp(angle(3 + 4im) * im)

# ╔═╡ 0ecee778-4da4-4a19-a8f2-6e28defc995b
24/5

# ╔═╡ a1f70fa6-0ec0-4891-9b67-31bacdb2b1e1
24÷5 #\div<TAB>

# ╔═╡ a2bfc8d6-e31c-41b4-9f8f-fcc0d88cf83b
24%5

# ╔═╡ 632d10c5-bd00-464d-bd56-8b899af525ef
md"#### Matrix slicing en puntsgewijze assignments
Het volgende programma definieert een matrix `Q` en manipuleert die vervolgens. 
"

# ╔═╡ 97a081f0-f0c6-48f2-ae4e-8e3ff5b99ff4
Q = [3 3 3; 4 4 5; 1 3 3]

# ╔═╡ ad0b9bb4-e701-461f-b23b-03581ab91891
Q[1:2:3, 1:2:3] .= 0 #de hoeken naar 0

# ╔═╡ 680937d2-5d0d-4872-8900-797e964e7ab5
Q

# ╔═╡ 82a8a87d-50e6-4bea-bacd-45c384601a2c
Q .= Q'

# ╔═╡ 678e4212-9611-47fd-b3cc-310683fdadbd
Q[2, 1:3] -= Q[1, 1:3]

# ╔═╡ d3c6b8d6-69d7-44c6-9162-af28a3d72b8f
Q

# ╔═╡ 31ac6378-22b5-4c4c-92cf-562b2d5b8123
Q[2, 1:2:3] .÷= Q[2, 1:2:3] #deel de middelste rij, behalve het centrum, puntsgewijs door zichzelf (gehele deling)

# ╔═╡ b6b64b80-6333-4579-9f2c-f25c53a27848
Q

# ╔═╡ d350e5d2-90fb-4212-a183-3999870ff9e5
Q[3, 2] -= Q[1,2]

# ╔═╡ 15da6d3c-bad9-4900-849c-24e3d50c8814
Q

# ╔═╡ 72d0417c-de29-4b2a-af89-c74016fbf6ad
md"#### Handige matrix functies
We beginnen met een paar basisoperaties op matrices. Vergeet niet om zelf cellen bij te maken en te experimenteren!
"

# ╔═╡ b06f3f6c-d038-4fa2-b675-8ede7e6348b6
zeros(4)

# ╔═╡ 149eeb32-2e57-4ed6-9715-d0a4fe00cc22
zeros(3, 5)

# ╔═╡ a0d6706c-3e81-4454-872d-3d09f64bfcd6
zeros(Int, 2, 3) #nulmatrix, met Int ipv Float

# ╔═╡ db486089-cfba-4e85-927e-0428abb3a623
ones(3,3)

# ╔═╡ a790ef3a-f974-4080-897f-034823b594f1
md"Het is vaak handig om willekeurige vectoren te genereren, dat kan met `rand` voor uniform verdeelde toevalswaarden, of `randn` voor normaal verdeelde toevalswaarden."

# ╔═╡ 7c4cb8d8-d97c-473d-b2fc-3e583209ad03
rand() # een willekeurig scalair van het type Float, tussen 0 en 1

# ╔═╡ eb1bc9a8-aab7-48ea-92cb-6b68d1561d29
rand(Int) #een willekeurige Integer tussen typemin(Int) en typemax(Int) 
#!!Bereken die waarden zelf eens

# ╔═╡ 75adcd97-cc6c-442d-9499-ff7a7b37405e
rand(2, 10)

# ╔═╡ a67f1409-2108-44c6-9703-19c3cc470e21
rand(Int, 3, 5)

# ╔═╡ 4beb86f4-9837-43c8-b7b8-996aa74f1479
rand(1:8) #een willekeurig getal uit de lijst 1, 2, ..., 8

# ╔═╡ 632099f4-f455-41ea-b122-45bc07cc656f
rand(1:8, 4, 3)

# ╔═╡ 4502bf24-721d-4288-b25c-30b40d7fbc08
rand(LinRange(0, 1, 11), 3) #3 waarden uit de lijst [0, 0.1, 0.2, ..., 0.9, 1]

# ╔═╡ d212b176-3c99-48c2-849a-a76be311b926
rand(["Julia", "MATLAB", "Python"]) #kies een willekeurig element uit een lijst

# ╔═╡ 60e43fcf-4b7f-4a2e-a00e-596e18f7c035
randn(3) #normaalverdeeld

# ╔═╡ 99b9b962-18bf-403e-8df0-f595d481aed6
plot(histogram(randn(10_000)), histogram(rand(10_000))) 
#plot 10 000 normaal verdeelde samples vs 10 000 uniform verdeelde samples

# ╔═╡ 92f3665f-2ae9-41d6-81dd-5575f5e57acb
md"De geavanceerdere matrix functionaliteit zit verzameld in de `LinearAlgebra` package."

# ╔═╡ b0e3f7e3-c8a7-42c8-acd9-78bedc707a65
zeros(3, 3) + I #I gedraagt zich als de eenheidsmatrix. Zijn afmetingen  en type worden aan de hand van de context bepaald.

# ╔═╡ 40874524-624a-44ed-b343-9c3e0cfe5ce0
zeros(Int, 2,2) + 3*I

# ╔═╡ 7fc47001-03c6-41da-8f64-3a32fb59f24c
md"Vervolgens berekenen we de eigenwaarde en vectoren van een matrix:"

# ╔═╡ 4ecb91bb-ccba-4d19-932f-2f48e214e941
H1 = [0 3 4; 
	  1 3 2;
	  2 2 2]

# ╔═╡ ff84efe5-f520-4bac-bcac-4ed88f5e27b0
eigvecs(H1)

# ╔═╡ be2aa742-17af-4ab4-bffe-5d210fe6f125
eigvals(H1)

# ╔═╡ 52e296ef-138a-4be8-8317-47d790e57edd
md"Natuurlijk kunnen we ook de determinant van een matrix bepalen:"

# ╔═╡ 75ab63d4-553d-422e-9049-339b1d7f7610
det(H1)

# ╔═╡ 7b01db27-3dd4-42e6-b4aa-442d2266670e
md"#### Kortere oneline functies met de ternary operator
Beschouw de functie

$$f(x) = \left\{\begin{array}{ll}
x^3 - x^2 - x &\text{als } x ≤ 0\\
\sin(x) &\text{als } x > 0
\end{array}\right.$$

We kunnen zo'n functie, zoals we in eerdere voorbeelden reeds zagen, als volgt implemnteren in Julia:
"

# ╔═╡ af8ede65-5d83-4090-b800-b5c3982034db
function f_versie1(x)
	if x <= 0
		return x^3 - x^2 - x
	else
		return sin(x)
	end
end

# ╔═╡ 11eb6987-be85-4b48-8ad7-78d5df97c9d8
md"Aangezien ``f`` een vrij eenvoudige functie is, zou het fijn zijn als we hem op een lijn zouden kunnen definiëren. Dat kan met behulp van de ternary operator:

`<CONDITIE> ? <ALS CONDITIE TRUE> : <ALS CONDITIE FALSE>`

Beschouw de volgende voorbeelden:"

# ╔═╡ 4e105db0-0f54-4595-9c9d-12695d35769c
2 + 2 == 5 ? "Winston" : "Julia"

# ╔═╡ 869a2652-17bc-4c45-b47b-1bf0d5176a92
0.2 < rand() < 0.5 ? "Winston" : "Julia"

# ╔═╡ 96c73a3a-d4c2-464a-96ee-6c0fda12b5eb
md"Maak nu gebruik van de ternary operator om `f_versie2` op 1 lijn te definiëren."

# ╔═╡ 0df0ab28-b31b-4b38-b0df-0ff5fb1b7574
f_versie2(x) = 0 #vervang door correcte uitdrukking

# ╔═╡ 681d5693-614f-4ac1-a3b2-7328bcfe18e2
md"Om visueel na te gaan dat de twee versies van de functie gelijk zijn, plotten we ze beiden op het interval ``[-1, 1]``."

# ╔═╡ 4b3998d1-2d04-4bb1-8aa5-8a78e702a339
let
	t = LinRange(-1, 1, 100)
	
	plot(t, f_versie1.(t), color=:purple, xticks=-1:0.2:1)
	plot!(t, f_versie2.(t), color=:orange, linestyle=:dot, linewidth=4, framestyle=:origin)
end

# ╔═╡ 5f37de56-bb6e-4811-9160-99f1b63e0875
md"#### List comprehensions
List comprehensions zijn een elegante, compacte en leesbare manier om Vectoren/Matrics/Arrays van een gewenste vorm te genereren.
"

# ╔═╡ 8897a771-2e72-4e9c-bddb-fccbdbfd79f0
[2^n for n=0:4]

# ╔═╡ 63bcdad7-c80d-4e41-91f1-44a7642de620
[x + y - 1 for x=1:4, y=1:5]

# ╔═╡ 4a34938b-8e6e-4da4-a2f9-e357ca331b19
md"List comprehensions kunnen natuurlijk ook in combinatie met de ternary operator gebruikt worden:"

# ╔═╡ 9612e89f-e061-46f3-b0b9-ee199da16c08
[iseven(x + y) ? 0 : 1 for x=0:3, y=99:102] 

# ╔═╡ 465e3893-ede1-4e79-a719-3b576e736698
md"Probeer een ``6\times 6`` diagonaalmatrix te genereren met een list comprehension in combinatie met een ternary operator."

# ╔═╡ 88c17f24-4fb3-4e48-9a35-21f2650d31a3
#code hier

# ╔═╡ f5c595b2-c48a-4373-960b-9aa25d70dc55
md"#### De ingebouwde `sum` en `prod` functies
De ingebouwde functie `sum` neemt als input een Vector/Matrix/Array of comprehension en berekent de som:
"

# ╔═╡ 81467415-4954-4fdc-b77a-8416d5c65c00
sum([1 2 3 4 5])

# ╔═╡ f1df2d03-26c8-4a9a-9fd5-4c861995cd33
sum([1 2 3; 4 5 6])

# ╔═╡ 0a9c54bb-682b-48b1-9b38-a95b63e523d1
sum([x^2 for x=3:8])

# ╔═╡ 2a0f9be5-ad48-4d79-95eb-cdb8603cf586
md"Dat laatste voorbeeld is niet erg efficiënt. We maken namelijk eerst een lijst aan (neemt geheugen in beslag) en berekenen vervolgens de som van die lijst. Dat kan beter:"

# ╔═╡ 7a2ea1cc-139c-4cd7-b928-245350139d63
sum(x^2 for x=3:8)

# ╔═╡ b557c766-dcb2-4a14-b31e-cd29a9c5ad84
md"De `prod` functie werkt natuurlijk volledig analoog."

# ╔═╡ c83f7804-a5ea-4bcf-b2c8-4b0f6e4f35c5
md"#### Strings
Bijzonder in Julia is dat twee Strings aan elkaar worden geplakt met de `*` operator in plaats van de `+` operator die in de meeste andere talen wordt gebruikt. Dat is eigenlijk een veel logischere keuze aangezien we ``a\times b`` vaak schrijven als ``ab`` terwijl we voor ``a + b`` geen andere notatie hebben.
"

# ╔═╡ 3a99038b-f999-4cd6-abb1-8a03b1449521
"ProFeSSor: " * "1 Frak" * " en 2 Schoenen."

# ╔═╡ 76d22458-b22e-4af9-9edb-bf0f6b855e35
md"Verder kan er in Julia Strings gebruik worden gemaakt van *interpolatie*. We illustreren dit met een voorbeeld."

# ╔═╡ e87f73a3-b031-495b-8e87-97cbd2812b24
assistent = "NAAM_ASSISTENT"

# ╔═╡ 67a7ab60-108b-4dc7-8d08-853f81905de9
naam = "JOUW_NAAM"

# ╔═╡ 9fed9a56-ac7f-4e95-aea9-b6565d93fc7c
"De favoriete leerling van $assistent is $naam."

# ╔═╡ 96a2714f-1550-4d60-a7ac-d616e3f1a83c
md"Maar ook ingewikkeldere constructies zijn mogelijk:"

# ╔═╡ 9a38cc68-9c09-4769-929f-4410e6026252
professor = "NAAM_PROF"

# ╔═╡ 5e08546c-6ea8-46cf-a69f-c14a58820bff
score = 14

# ╔═╡ b4e8a22f-ad01-402f-8821-8a8ba84b1217
"Prof. $professor gaf met een $score, maar ik verdiende een $(round(Int, exp(score) + score^2))"

# ╔═╡ 0206b776-00af-42f8-9e84-1f57c5d9dcb2
"Als je mijn naam $naam omdraait, dan krijg je $(reverse(naam))"

# ╔═╡ bbe81be5-e34d-4696-9696-d738b2113f85
md"#### Relationele en logische operatoren
Eerst definiëren we een aantal matrices.
"

# ╔═╡ dd70c88b-32b7-4ca9-8a9e-f9eea8489f92
A = rand(3, 2)

# ╔═╡ 565684f6-3af4-43e5-928f-69b0c49d127f
B = rand(3, 2)

# ╔═╡ eedbef48-8576-4760-a3d8-62d541844a37
C = copy(A)

# ╔═╡ e4da6ac3-eaee-488d-9d3c-3ccd4a757ee0
D = A

# ╔═╡ 1aee8401-46fd-4bbe-a6f3-9ce954f6d2f6
md"Vervolgens testen we de gelijkheidsoperatoren `==` en `===` (hun tegenhangers zijn `!=` en `!==`)."

# ╔═╡ 8d754a53-ec27-4afe-bd62-8e9de763ece4
A == B #false, ze zijn verschillend

# ╔═╡ 6616b702-1bf4-4df5-bb74-773d168125c2
A == C #ja C is een kopie van A

# ╔═╡ 9bb4c8ee-75f8-4ce3-8b67-200f48a55ed5
A === C #false, A en C zijn wel gelijk maar leven niet in hetzelfde stuk geheugen

# ╔═╡ a3eb3595-514e-482c-a95d-067eaa751ce4
A === D #true, A en D verwijzen naar hetzelfde object

# ╔═╡ f0a1c792-bd41-41d2-a8b8-7a3ef70e0a7b
md"Verder hebben we ook nog `<` en `<=` (equivalent aan `≤`, wat je invoert door `\leq<TAB>` te typen)."

# ╔═╡ 6272e43d-978b-41ef-942d-367d68456602
3 < 4

# ╔═╡ b58d5afe-8748-4d38-afbb-06de4045e698
5 ≤ 4

# ╔═╡ 4f6a1d1d-0d15-41c1-a8f9-c20e67106d92
md"Natuurlijk werken deze operator ook puntsgewijs."

# ╔═╡ b38e5061-b771-4ead-a5f7-550b16210d68
A .< B

# ╔═╡ d13b243c-38a9-4ca7-a3e1-e458cc6be40e
md"Ten slotte hebben we ook nog `!` (not), `&&` (and) en `||` (or):"

# ╔═╡ 8150e5d2-7ab1-41a1-9ca9-80a9dc254c17
!true

# ╔═╡ 9dd0b6e1-bcff-4b6d-835e-73907716cb1e
false && true

# ╔═╡ af38befb-1ae1-49e9-8dfb-575b21e8ef64
true || false

# ╔═╡ 8c6880e4-32ec-4a5e-a29c-20120fa31fe6
md"""#### For loops
Gegeven een Array `K` (in dit voorbeeld een `Matrix`), kunnen we op verschillende manieren over de elementen van `M` itereren. In het eerste voorbeeld gebruiken we de "klassieke" manier om over de elementen van een matrix te itereren: via 2 geneste `for` loops:
"""

# ╔═╡ fdf2a890-c75d-4255-85c7-bd3cc3e595c0
K = rand(2, 5)

# ╔═╡ 7471e01d-7b99-4000-9e53-a6e0ac83644a
let
	newK = zeros(size(K)) #nulmatrix even groot als K
	
	for j=1:size(K,2)
		for i=1:size(K,1) 
			newK[i, j] = K[i, j]^2
		end
	end
	#performance tip: altijd kolommen in binnenste lus wegens samenhang in computergeheugen
	newK
end

# ╔═╡ 835d59cf-73ea-4d85-a4cf-27f4b04f77e3
md"In de volgende voorbeelden zoeken we steeds naar het grootste element in `K`:"

# ╔═╡ 71b7de70-4136-48d5-9399-f07e34409dbe
let
	#we stellen de beginwaarde van M gelijk aan de minimale waarde die een element van K kan hebben. Voer dit commando eens uit in een aparte cel om het beter te begrijpen.
	M = typemin(eltype(K)) 
	
	for i=1:length(K)
		if K[i] > M
			M = K[i]
		end
	end
	
	M
end

# ╔═╡ 8b0b7513-1271-4519-b525-202a1f46360d
let
	M = typemin(eltype(K)) 
	
	for k in K
		if k > M
			M = k
		end
	end
	
	M
end

# ╔═╡ b8b25044-e09c-4cec-a58e-92c2aadfca1d
let
	M = typemin(eltype(K)) 
	idx_M = 0
	
	for idx in eachindex(K)
		if K[idx] > M
			M = K[idx]
			idx_M = idx
		end
	end
	
	M, idx_M
end

# ╔═╡ 55640801-146a-45a6-8d74-e0ea36aac298
let
	M = typemin(eltype(K)) 
	idx_M = 0
	
	for (idx, value) in enumerate(K)
		if value > M
			M = value
			idx_M = idx
		end
	end
	
	M, idx_M
end

# ╔═╡ aee01040-4a40-443c-be11-e42cba1ac525
md"Ten slotte biedt Julia nog een oplossing voor de slordigheid die geneste `for` loops teweeg kunnen brengen:"

# ╔═╡ 592ae9d2-5245-478f-b7e9-fbb8593ae3e7
let
	U = zeros(4, 4)
	for i=1:4
		for j=1:4
			for k=1:8
				U[i, j] += k^2
			end
		end
	end
	U
end

# ╔═╡ 772b145d-e949-475a-8dce-0d9db809aa71
md"De bovenstaande code kan vereenvoudigd worden naar:"

# ╔═╡ 42b1fafd-898d-48a4-bd9c-9e301b5af57e
let
	U = zeros(4, 4)
	for i=1:4, j=1:4, k=1:8
		U[i,j] += k^2
	end
	U
end

# ╔═╡ 4b0d55e8-9b16-47a6-b0fd-62c8a13df7de
md"#### Recursieve functies
Het volgende voorbeeld definieert twee functies die het ``n``de getal uit de rij van Fibonacci berekenen.
"

# ╔═╡ b87d6a15-89e2-4f1e-9e7e-aaa541bedd7e
function fibo_rec(n)
	if n == 1 || n == 2
		return 1
	else
		return fibo_rec(n-1) + fibo_rec(n-2)
	end
end

# ╔═╡ 5f57dbcd-cd44-4481-a6c3-f35186541b27
fibo_rec.(1:10) #de eerste 10

# ╔═╡ f629deff-2380-439b-bafa-dfc34ac7717a
function fibo_it(n)
	if n == 1 || n == 2
		return 1
	end
	
	a = 1
	b = 1
	
	for k=3:n
		a, b = b, a+b
	end
	
	return b
end

#alternatief voor
		#a, b = b, a+b
#is
		#b_copy = b
		#b = b + a
		#a = b_copy
		

# ╔═╡ 52af5b18-b3b1-4d60-a318-817d39005027
fibo_it.(1:10)

# ╔═╡ 4d101a73-6b77-4641-ba2d-645b66d3d713
md"### Gevorderde functionaliteit
#### Type-annotation in functies
In Julia hoef je bijna nooit over de types van je variabelen na te denken. Julia is slim genoeg om dat voor jou te doen. 

Je hebt echter wel de mogelijkheid. Beschouw de volgende functie `zoek_in_lijst(lijst, element)` die `true` teruggeeft als het `element` voorkomt in `lijst`:
"

# ╔═╡ eb4a1cea-aae1-4800-8f73-36f10af5b543
function zoek_in_lijst_v1(lijst, element)
	for xi in lijst
		if xi == element
			return true
		end
	end
	return false
end

# ╔═╡ f48d6ddb-f81a-4ee6-8eac-8bab62769070
md"Het probleem met deze definitie is dat we om het even welke argumenten kunnen meegeven:"

# ╔═╡ c0fad7ba-fd55-4b5d-bc30-87c00488ed99
zoek_in_lijst_v1([1 2 3 4], 8) #zinnig

# ╔═╡ c763e519-ade6-4272-a913-d0a11cb90fa5
zoek_in_lijst_v1(false, 3) #onzin!

# ╔═╡ e1c243f3-2b05-482d-8745-f3184e006b99
md"Als we echter aan de gebruiker willen duidelijk maken dat `lijst` alleen van het type `Array` mag zijn, en dat de functie een waarde van het type `Bool` teruggeeft, dan kunnen we gebruik maken van type-annotatie:"

# ╔═╡ 9a605a62-5a9b-46ba-916b-07ff6672287b
function zoek_in_lijst_v2(lijst::Array, element)::Bool
	for xi in lijst
		if xi == element
			return true
		end
	end
	return false
end

# ╔═╡ 0ab826eb-1117-4b88-84a3-98cf19c976d1
zoek_in_lijst_v2([3 4 5 9], 99)

# ╔═╡ 98228370-6b93-47e4-8129-caa2dbe2f485
zoek_in_lijst_v2(3, 99) #onzin

# ╔═╡ 24995364-439e-4481-b120-e8627b58ffcc
md"**Opmerking:** onze definitie van `zoek_in_lijst_v2` is iets te strikt. We kunnen `zoek_in_lijst_v2`  niet meer gebruiken om te bepalen of bijvoorbeeld `0.3` voorkomt in `LinRange(0, 1, 11)`. Dat komt omdat `LinRange(0, 1, 11)` geen `Array` is."

# ╔═╡ ac1d692e-6967-429c-b562-c2be6d4b8a63
zoek_in_lijst_v2(LinRange(0, 1, 11), 0.3)

# ╔═╡ 28d67a4b-abe8-46df-b6bb-2487dbf3e33e
md"`LinRange`, en andere types die zich gedragen als een `Array` maar er geen zijn, zijn in Julia geïmplementeerd als een *subtype* van `AbstractArray`. Dat leidt ons naar de finale versie van onze functie:"

# ╔═╡ 3bcfd003-5c6f-4cd8-b9f1-60769cbc3d63
function zoek_in_lijst_v3(lijst::AbstractArray, element)::Bool
	for xi in lijst
		if xi == element
			return true
		end
	end
	return false
end

# ╔═╡ fad1b1f0-2052-43fb-9e77-f5bfb413f3e9
zoek_in_lijst_v3(LinRange(0, 1, 11), 0.3)

# ╔═╡ 24198787-92e1-47d1-af6e-1a1403f458d8
md"En gelukkig nog steeds:"

# ╔═╡ 851ed215-a8b4-41e7-9e73-36f6acf59a50
zoek_in_lijst_v3(3, 99) #onzin

# ╔═╡ f3076f20-e98a-483f-a06e-9cb3ff5ccfdb
md"**Opmerking:** in Julia kun je ook je eigen types definiëren. Raadpleeg voor meer informatie de officiële Julia documentatie."

# ╔═╡ c1d5d67a-e081-4d21-a85d-7e3ecc7f2c67
md"Om na te gaan of een type `A` een subtype is van type `B` kun je

`B <: A` 

schrijven:"

# ╔═╡ 288cf2bd-d68f-4394-bc26-6286c4cd9af3
Int <: Float64

# ╔═╡ e269a442-2416-45e5-9dd0-4d69a21f03a4
Vector <: Array

# ╔═╡ bb40b310-6de7-4939-a547-bfddf03ffb27
Vector <: Matrix

# ╔═╡ b4c712a3-ad94-42b5-9d5f-d61698603c3b
Matrix <: Array

# ╔═╡ 7505024d-5a38-4ce8-9355-afb10c367751
Array <: AbstractArray

# ╔═╡ 5cea7991-699e-4041-ab67-b9f985128007
Vector <: AbstractArray

# ╔═╡ 60f1dcaf-fcd4-4389-ba01-b02dfb1393d4
typeof(LinRange(0,1,101)) <: AbstractArray

# ╔═╡ afb44799-b4f9-4ccb-9362-0faf02ccac82
typeof(1:9) <: AbstractArray

# ╔═╡ 4785c17f-d1f7-4c57-a765-66df97781833
md"**Opmerking:** in Julia kun je ook schrijven:"

# ╔═╡ 12201881-dd56-4316-bb0b-458cdeb758bb
3 in [1 2 5 9 1 3]

# ╔═╡ 14c4cdde-e483-4ebd-a561-457e713934b7
33 in [1 2 5 9 1 3]

# ╔═╡ d8001506-4983-4738-826a-89e160f796ab
3 ∈ [1 2 5 9 1 3]

# ╔═╡ a98cae60-8751-4c64-90f6-9583d240aa01
md"""#### Pipes
In datascience moeten we vaak een groot aantal transformaties uitvoeren op onze data. De data moet als het ware door een hele "pijplijn" van functies stromen. Het volgende voorbeeld illustreert dit:
"""

# ╔═╡ 5c3e8f2c-82b6-4bbd-9b10-95ba22030059
data = randn(10)

# ╔═╡ 16a75f24-6f32-4867-becf-bf99921928bd
let
	data2 = reverse(data) #draai de data om
	data3 = abs.(data2) #absolute waarde berekenen
	data4 = sqrt.(data3) #kwadrateer de data
	data5 = sum(data4) #bepaal de som
end

# ╔═╡ a62695a3-0cb5-45cf-9068-a9124a9e40cf
md"We kunnen dit ook op een lijn schrijven, door het onmiddellijk achter elkaar uitvoeren van de functies:"

# ╔═╡ d00142d9-76bd-4d08-8a28-c8f8c52a30ee
data5 = sum(sqrt.(abs.(reverse(data))))

# ╔═╡ 5d79a823-d7bb-42f4-983f-dca60a3999ba
md"Dit niet zo leesbaar meer voor onze Westerse ogen, aangezien we de functies van rechts naar links moeten uitvoeren. Julia heeft hier natuurlijk een elegante oplossing voor: de pipe operator `|>` en zijn elementsgewijze variant `.|>`:"

# ╔═╡ 4bd3d80c-932f-46a2-870f-99fc00f26ae7
data |> reverse .|> abs .|> sqrt |> sum

# ╔═╡ 353eb275-3c22-492a-850a-11012004422e
md"Als we tussen de vierkantswortel en de som de data nog eens elementsgewijs zouden willen verheffen tot, bijvoorbeeld, de derde macht, dan zouden we een functie `derdemacht(x) = x^3` kunnen definiëren en die daar dan tussen plakken, of we zouden gebruik kunnen maken van een *annonieme functie*:"

# ╔═╡ c462b1fa-bc51-4b35-aec1-804d658de957
data |> reverse .|> abs .|> sqrt .|> (x -> x^3) |> sum

# ╔═╡ 6c07ec9e-5fcf-495a-8759-bf743f93daa9
md"Dankzij annonieme functies, kunnen we nu ook functies die meer dan een argument vereisen toevoegen aan onze pijplijn! De functie `round(x, digits=n)` rondt `x` af tot `n` cijfers na de komma. Laten we het resultaat afronden tot 3 cijfers na de komma:"

# ╔═╡ ff00eba0-dd64-4f51-9746-7f848164edc3
data |> reverse .|> abs .|> sqrt .|> (x -> x^3) |> sum |> (x -> round(x, digits=3))

# ╔═╡ aa001081-ee2c-4d48-84dd-c78229f8e71c
md"Natuurlijk gebruik je liefst zo veel mogelijk niet-annonieme functies om je programma leesbaar te houden!"

# ╔═╡ ab7e655d-114f-4c42-a295-b4c31119863c
md"""**Opmerking:** de Julia community voert momenteel een debat om de vaak gebruikte notatie

`... |> (x -> f(x, arg1, arg2, ...)) |> ...`

te vereenvoudigen naar

`... |> f(_, arg1, arg2, ...) |> ...`

waarbij `_` dan "ingevuld" wordt. Dat zou betekenen dat we de vorige pijplijn kunnen vereenvoudigen naar

`data |> reverse .|> abs .|> sqrt .|> (x -> x^3) |> sum |> round(_, digits=3)`"""

# ╔═╡ 30fd63ec-0282-430b-9408-e3d77fb8aeed
md"#### Timing en benchmarking
Om het tijd- en geheugengebruik van je functies te meten, kun je gebruik maken van de package `BenchmarkTools`:
"

# ╔═╡ 173d8e66-79d9-4871-bbf5-7edd7138722e
function slowsum(n)
	return sum([k^2 - k for k=1:n])
end

# ╔═╡ 1c3bd18e-384b-4595-aefd-0bc60ebf1a8a
function fastersum(n)
	return sum(k^2 - k for k=1:n)
end

# ╔═╡ 68eea311-7d94-4fcb-a450-a9fde2651f5b
function ik_ken_gewoon_de_formule(n)
	return n*(n+1)÷2
end

# ╔═╡ 0a9ed3d9-0366-4038-84d9-5f87e774faac
md"""We gebruiken het macro `@btime` om de daaropvolgende expressie een aantal keer uit te voeren en de gemiddelde uitvoeringstijd te meten alsook het geheugengebruik. `@btime` plaatst die output dan in de terminal waarin je Pluto gestart hebt. Om die output toch binnen Pluto te "vangen", moeten we de `@btime` omsluiten in een `with_terminal() do ... end` blok."""

# ╔═╡ 446744c1-862d-4ca7-8546-bfb9d9634bfa
md"Als de volgende cel een error geeft, is dat omdat de functie `with_terminal` een onderdeel is van de `PlutoUI` package, en je die laatste nog niet hebt geïnstalleerd. 

Maak een nieuwe cel aan waarin je eerst `PlutoUI` installeert en vervolgens importeert."

# ╔═╡ b289b895-f9c0-4942-b43e-536700dca28b
with_terminal() do #hebben we nodig om de output te zien
	@btime slowsum(1_000_000)
end

# ╔═╡ 9c5b918f-0011-4703-b14d-af63269fbe14
with_terminal() do #hebben we nodig om de output te zien
	@btime fastersum(1_000_000)
end

# ╔═╡ be1102d0-3a00-4a21-8731-f277fe408b01
with_terminal() do #hebben we nodig om de output te zien
	@btime ik_ken_gewoon_de_formule(1_000_000)
end

# ╔═╡ e9317e3d-e0f7-4a21-b74a-bfad3a64c14a
md"De verschillen zijn gigantisch, zowel in tijd als in geheugengebruik. Het leren beheersen van de taal Julia is een lang proces, maar wel enorm bevredigend. Als laatste oefening kan je het verschil meten tussen de twee Fibonacci functies. Vul bij de recursieve versie wel geen waarde hoger dan 20 als je je computer deze week nog wilt gebruiken."

# ╔═╡ 284fda9d-0cf9-4448-9011-3de1b10d366f
#test fibo_rec

# ╔═╡ eb385960-9e51-4f24-ba5c-81ebf6d4c830
#test fibo_it

# ╔═╡ Cell order:
# ╟─065f9b00-ce70-11eb-1ee1-5d39cf5e39fc
# ╟─c5d21e48-12e1-49e0-b1ac-1695c18fc7f2
# ╟─47a2c712-dc44-4ff4-bdf6-0d78178812cb
# ╠═b868460c-f229-4d0a-ac98-42e76cad1a1b
# ╟─301dfceb-77d6-4c35-b62a-ffbdb63133d7
# ╠═250be0f8-db4b-48c5-8d96-f64acfd012d6
# ╟─4a0c5464-12aa-4e44-bdcc-bc0facab94a7
# ╠═278ab1cf-9935-4eb5-afdf-65d98295491b
# ╟─e39d5f41-5df8-43d3-bda0-990860dac893
# ╠═e666713a-e983-4435-949e-15fda6d89da0
# ╟─5a96d25f-3a80-484c-89eb-0a5d7cd31b95
# ╠═2450a720-7ba4-4fec-83a9-3f4cfb4fdc78
# ╠═31aa20a2-cf79-4c04-af18-62ce498b94da
# ╟─1c6f70a5-f39e-4667-ae70-d545f138720b
# ╠═a25aeab8-e9ba-41bd-b0d1-f2754166d2a3
# ╠═f59c258f-21e8-43ac-ad5c-7eec51da6a57
# ╠═14bfc8ae-c5b8-43d4-a628-595693dd2832
# ╟─8c703f1c-43ae-407a-b62f-d1999ff34caa
# ╠═bfcab42a-1342-476c-9087-a0c7d7c2f492
# ╟─c337d274-abe1-4cfe-ac87-294b80075330
# ╠═4d3420dd-26ce-4d0e-af5b-50b1e6b87c5a
# ╟─76a41e87-64df-4d07-9516-7ffd4796b258
# ╠═a111340d-c2b1-4c38-be08-7de3a60488ae
# ╠═ac737b66-2c3f-45bb-bd75-22053e9e5802
# ╟─7218f1f9-79cd-4f09-9062-4e4067ab8907
# ╠═023f4cec-a9d8-4917-bd3a-82671810b7dc
# ╟─3ca36760-70e7-420c-99af-fa5be4f05e56
# ╠═41dc1743-ec11-49f1-b9c6-adc3aa472cbd
# ╠═4f940fb4-137f-4b04-bb0d-920aa2c2ec74
# ╠═d3c4b019-b840-44ad-abe3-eeef6c1442f5
# ╟─08b75692-7668-4871-ae68-27e0f3ade957
# ╠═94c4d137-cf34-4481-9a9d-0747e9a0d963
# ╠═753d2408-7c51-41dc-8c4c-eb7e11f0d8bb
# ╟─2e821c0e-39fd-4bd4-a5bc-b746057581aa
# ╟─0c226ac3-b287-44f7-b8b9-dfdee33f1664
# ╠═33d6b3e1-15aa-486a-9430-9cf50b770f89
# ╠═5cacc4bf-5d33-4e34-a6cc-c29d4099c7a7
# ╠═a3c7c7db-7ad5-4f90-a13e-d8c645091c56
# ╠═a1b3e668-e1e9-443f-90e9-2dc48bb78808
# ╠═8366c38f-8bcd-474e-a126-d03d91874a05
# ╠═75e789f0-080d-47ab-9814-c42e544c8be5
# ╠═cfeebf19-6524-4ab5-a785-59821858c154
# ╠═a6e03bc3-5dbc-4dca-9a99-94d6c76e86af
# ╟─8c4f7bf5-3425-4d65-a074-252eeaffec6b
# ╠═2873b7ed-730d-413d-be83-b5ac87890a59
# ╠═be2a71b3-fdd8-4418-989c-c9fa45fad226
# ╠═5b04b4bb-d8dd-437b-bf29-d0d38ad8e9c5
# ╠═1bd9328e-52a1-4be6-a5c8-fe579f067f45
# ╟─d25571ac-f9b7-486e-a24d-ad3c66d971f1
# ╟─0b3c812a-a8bf-48ba-96a7-694647cdd3c9
# ╠═46f841eb-b35e-4095-b9eb-61538aa56ff8
# ╠═7036709e-8cd3-43c8-9125-38a7aaecce19
# ╠═b080a19d-8193-48ec-98c6-a5adce99f689
# ╠═26a802e8-8df6-46e4-b087-b3db84645eed
# ╠═500826c8-7089-42f6-8f40-8e3aa01de986
# ╟─7b75f643-9eff-436e-8745-4479b1861ea7
# ╠═de7c2a28-25b3-49d4-a848-6eced7a4afc2
# ╟─0f57884d-9ebe-4354-a133-f4b9266565a5
# ╠═9d1139bd-3c58-4e5e-a09f-e88cc02a3a28
# ╟─16a4cb60-3cfa-4f50-b0a1-f782252b1556
# ╠═cd1aa28d-ecc4-47cc-8d0c-074e68f699b3
# ╟─cf62badc-4828-474e-9be3-69f46caad71f
# ╠═6a64f91d-fc6e-4e2b-89fe-29888d6595c5
# ╠═07a585b7-65dd-4209-85e4-8e3442ac0160
# ╟─6ab7e445-beb5-4c09-99b2-aed428017b59
# ╠═c9ca7dcb-9e80-4d91-bf92-cc23b2e4558f
# ╠═8c286d60-1a84-4411-82ca-59ed605a40c3
# ╟─6a095ac0-ef7f-484c-95ce-70d05a954598
# ╠═ee01eda9-f9c2-472b-b7c0-6e2268e6b6d9
# ╠═89e98a65-2190-47ec-9291-78152254bd15
# ╟─b6e1919e-67f3-4111-8a22-7a8e5f3391e3
# ╠═2f44e545-1c6d-40de-a672-5b74ee6668c1
# ╟─4ee457f7-363c-4e3f-9672-06cbc0c5149e
# ╠═88ef2a42-d141-442a-9a2c-dc8101488ea0
# ╟─51b03a13-3577-4838-8786-cbeecd2031be
# ╠═6a30d20e-3b97-45c3-95e1-c475e645b716
# ╠═abf65b18-3d4d-4c3a-ae67-d9493ff38845
# ╠═95b14d2c-d4d6-416f-a419-795e617b7996
# ╠═3a812e19-acf8-4b56-ae8a-371d1feb456a
# ╟─4b96e09f-e9b0-4551-816d-d930b497deba
# ╠═614a2f14-6a62-4255-8495-f6987dd7ead0
# ╟─c0fbdac3-c250-4029-9ab6-70d8ea30aaa6
# ╠═d956b439-dee4-4b51-a7b0-98fccd7bbf99
# ╟─69d81a78-e94d-4bed-9a7b-b634041736a9
# ╠═a9f37ee3-45e7-4ae5-bdc6-449d871bead6
# ╠═3fef6aca-e4f1-4f15-b013-4c42849da952
# ╠═f5a5b028-6ed8-4651-8c5b-fc3eedef5d64
# ╟─bfbfc377-0f11-4f86-8f30-1737f98b82c8
# ╠═d6788779-fc9f-431c-b247-6f9da302fc00
# ╟─96bb54fd-cced-42ae-bc9a-2935617ffe48
# ╠═a2bddf16-b6c3-4b09-9729-1ec6e7b1f073
# ╠═22410d92-2b7e-4a3f-8190-79b5562b4289
# ╟─9b29d263-6ace-4025-8b93-fa7ea9e02bb1
# ╠═9a710788-4e90-4cee-b095-7c9b8e0e6462
# ╟─7c581841-0ac6-4a42-8e3d-ecadfd325064
# ╠═e1dbf1f6-864e-46c9-8f0e-84a335c8a40f
# ╟─81dace0a-1bfd-48fb-9cb0-4f38fb3e843b
# ╟─e8a26313-964d-4ed7-a58a-4583c1f82a87
# ╠═4c6bf641-8695-4f32-aa4c-72c07ad463d6
# ╠═5ffead21-503c-4caf-b5f4-895657ea7243
# ╟─8596436c-1d61-48f3-935e-30f5a934797f
# ╠═a9b52560-bea6-4707-a8a5-8453f3b44aec
# ╠═645ec134-ce39-40b6-840b-e256331c1aec
# ╟─98bd5286-58a2-4750-8b39-f2d0c221b074
# ╠═b2b05431-5750-437f-bf33-802821c0a21a
# ╠═56dad723-0afb-4d79-bb03-5aea56853002
# ╟─d80c5aa0-6635-4de4-aab1-22e2ff7a98ab
# ╠═3c660b08-d878-4e90-a0cd-7c9a0e08106d
# ╟─ea440d78-1d5f-4455-9cca-73d6ae6690ad
# ╠═11450cdf-0a75-435b-9cbd-0ede916d2939
# ╟─e3acd775-2792-448f-9d3c-70785282945e
# ╠═b94dc16e-4230-43d4-acee-9ba9eb3b5cd6
# ╟─b5f7417b-e51a-46de-b7c0-5de3448d84ee
# ╠═79e6acae-3f81-4110-9d3c-ecc3ebdf8fb7
# ╟─2d3ceaf9-9ce2-49b8-ba50-96fbc3d4314f
# ╠═7c9b266c-4cae-48dc-aab1-bfb74560bcb1
# ╟─11f2d5e0-c5a7-411b-9a01-8786b99f8e56
# ╠═51645a3c-51b8-47a7-b2dc-2bcdd356ca37
# ╟─9cd2914a-e540-4131-8606-3533aaa16887
# ╠═72f7d7a6-55ce-4ba2-97d3-99bae26f54b1
# ╟─7b766daf-f703-4dfd-a09c-c7439078574a
# ╟─2ea91520-caa3-40ae-bbd4-8e122d253528
# ╠═0269c3bc-0c2e-4095-ac9b-af62429f74ec
# ╠═e4a99736-a706-489c-99a3-fc50b04d73f1
# ╠═b0dbedbb-993a-4406-ade0-dbe3d83eb626
# ╠═0398cfd3-4b37-4c16-a2bd-de8764ec4dec
# ╠═3dbb2f16-9639-4242-9777-4152d65b87cf
# ╠═875ad7bc-edfe-4db4-8a55-524df9cbefc8
# ╠═14d9a28d-fb1e-4ded-acd9-9e9ad92396b4
# ╠═7c21e16a-cd54-4747-8884-ad69c3696734
# ╠═5e623855-b9fe-42bc-84b1-49406114b0ef
# ╠═680fb1fa-ac22-4567-8267-7087952a15c9
# ╠═e66a28d7-0782-4734-8aaa-c8bd458b4cb0
# ╠═0ecee778-4da4-4a19-a8f2-6e28defc995b
# ╠═a1f70fa6-0ec0-4891-9b67-31bacdb2b1e1
# ╠═a2bfc8d6-e31c-41b4-9f8f-fcc0d88cf83b
# ╟─632d10c5-bd00-464d-bd56-8b899af525ef
# ╠═97a081f0-f0c6-48f2-ae4e-8e3ff5b99ff4
# ╠═ad0b9bb4-e701-461f-b23b-03581ab91891
# ╠═680937d2-5d0d-4872-8900-797e964e7ab5
# ╠═82a8a87d-50e6-4bea-bacd-45c384601a2c
# ╠═678e4212-9611-47fd-b3cc-310683fdadbd
# ╠═d3c6b8d6-69d7-44c6-9162-af28a3d72b8f
# ╠═31ac6378-22b5-4c4c-92cf-562b2d5b8123
# ╠═b6b64b80-6333-4579-9f2c-f25c53a27848
# ╠═d350e5d2-90fb-4212-a183-3999870ff9e5
# ╠═15da6d3c-bad9-4900-849c-24e3d50c8814
# ╟─72d0417c-de29-4b2a-af89-c74016fbf6ad
# ╠═b06f3f6c-d038-4fa2-b675-8ede7e6348b6
# ╠═149eeb32-2e57-4ed6-9715-d0a4fe00cc22
# ╠═a0d6706c-3e81-4454-872d-3d09f64bfcd6
# ╠═db486089-cfba-4e85-927e-0428abb3a623
# ╟─a790ef3a-f974-4080-897f-034823b594f1
# ╠═7c4cb8d8-d97c-473d-b2fc-3e583209ad03
# ╠═eb1bc9a8-aab7-48ea-92cb-6b68d1561d29
# ╠═75adcd97-cc6c-442d-9499-ff7a7b37405e
# ╠═a67f1409-2108-44c6-9703-19c3cc470e21
# ╠═4beb86f4-9837-43c8-b7b8-996aa74f1479
# ╠═632099f4-f455-41ea-b122-45bc07cc656f
# ╠═4502bf24-721d-4288-b25c-30b40d7fbc08
# ╠═d212b176-3c99-48c2-849a-a76be311b926
# ╠═60e43fcf-4b7f-4a2e-a00e-596e18f7c035
# ╠═99b9b962-18bf-403e-8df0-f595d481aed6
# ╟─92f3665f-2ae9-41d6-81dd-5575f5e57acb
# ╠═789d0bc6-235d-433f-be4d-f9200fb94a71
# ╠═b0e3f7e3-c8a7-42c8-acd9-78bedc707a65
# ╠═40874524-624a-44ed-b343-9c3e0cfe5ce0
# ╟─7fc47001-03c6-41da-8f64-3a32fb59f24c
# ╠═4ecb91bb-ccba-4d19-932f-2f48e214e941
# ╠═ff84efe5-f520-4bac-bcac-4ed88f5e27b0
# ╠═be2aa742-17af-4ab4-bffe-5d210fe6f125
# ╟─52e296ef-138a-4be8-8317-47d790e57edd
# ╠═75ab63d4-553d-422e-9049-339b1d7f7610
# ╟─7b01db27-3dd4-42e6-b4aa-442d2266670e
# ╠═af8ede65-5d83-4090-b800-b5c3982034db
# ╟─11eb6987-be85-4b48-8ad7-78d5df97c9d8
# ╠═4e105db0-0f54-4595-9c9d-12695d35769c
# ╠═869a2652-17bc-4c45-b47b-1bf0d5176a92
# ╟─96c73a3a-d4c2-464a-96ee-6c0fda12b5eb
# ╠═0df0ab28-b31b-4b38-b0df-0ff5fb1b7574
# ╟─681d5693-614f-4ac1-a3b2-7328bcfe18e2
# ╠═4b3998d1-2d04-4bb1-8aa5-8a78e702a339
# ╟─5f37de56-bb6e-4811-9160-99f1b63e0875
# ╠═8897a771-2e72-4e9c-bddb-fccbdbfd79f0
# ╠═63bcdad7-c80d-4e41-91f1-44a7642de620
# ╟─4a34938b-8e6e-4da4-a2f9-e357ca331b19
# ╠═9612e89f-e061-46f3-b0b9-ee199da16c08
# ╟─465e3893-ede1-4e79-a719-3b576e736698
# ╠═88c17f24-4fb3-4e48-9a35-21f2650d31a3
# ╟─f5c595b2-c48a-4373-960b-9aa25d70dc55
# ╠═81467415-4954-4fdc-b77a-8416d5c65c00
# ╠═f1df2d03-26c8-4a9a-9fd5-4c861995cd33
# ╠═0a9c54bb-682b-48b1-9b38-a95b63e523d1
# ╟─2a0f9be5-ad48-4d79-95eb-cdb8603cf586
# ╠═7a2ea1cc-139c-4cd7-b928-245350139d63
# ╟─b557c766-dcb2-4a14-b31e-cd29a9c5ad84
# ╟─c83f7804-a5ea-4bcf-b2c8-4b0f6e4f35c5
# ╠═3a99038b-f999-4cd6-abb1-8a03b1449521
# ╟─76d22458-b22e-4af9-9edb-bf0f6b855e35
# ╠═e87f73a3-b031-495b-8e87-97cbd2812b24
# ╠═67a7ab60-108b-4dc7-8d08-853f81905de9
# ╠═9fed9a56-ac7f-4e95-aea9-b6565d93fc7c
# ╟─96a2714f-1550-4d60-a7ac-d616e3f1a83c
# ╠═9a38cc68-9c09-4769-929f-4410e6026252
# ╠═5e08546c-6ea8-46cf-a69f-c14a58820bff
# ╠═b4e8a22f-ad01-402f-8821-8a8ba84b1217
# ╠═0206b776-00af-42f8-9e84-1f57c5d9dcb2
# ╟─bbe81be5-e34d-4696-9696-d738b2113f85
# ╠═dd70c88b-32b7-4ca9-8a9e-f9eea8489f92
# ╠═565684f6-3af4-43e5-928f-69b0c49d127f
# ╠═eedbef48-8576-4760-a3d8-62d541844a37
# ╠═e4da6ac3-eaee-488d-9d3c-3ccd4a757ee0
# ╟─1aee8401-46fd-4bbe-a6f3-9ce954f6d2f6
# ╠═8d754a53-ec27-4afe-bd62-8e9de763ece4
# ╠═6616b702-1bf4-4df5-bb74-773d168125c2
# ╠═9bb4c8ee-75f8-4ce3-8b67-200f48a55ed5
# ╠═a3eb3595-514e-482c-a95d-067eaa751ce4
# ╟─f0a1c792-bd41-41d2-a8b8-7a3ef70e0a7b
# ╠═6272e43d-978b-41ef-942d-367d68456602
# ╠═b58d5afe-8748-4d38-afbb-06de4045e698
# ╟─4f6a1d1d-0d15-41c1-a8f9-c20e67106d92
# ╠═b38e5061-b771-4ead-a5f7-550b16210d68
# ╟─d13b243c-38a9-4ca7-a3e1-e458cc6be40e
# ╠═8150e5d2-7ab1-41a1-9ca9-80a9dc254c17
# ╠═9dd0b6e1-bcff-4b6d-835e-73907716cb1e
# ╠═af38befb-1ae1-49e9-8dfb-575b21e8ef64
# ╟─8c6880e4-32ec-4a5e-a29c-20120fa31fe6
# ╠═fdf2a890-c75d-4255-85c7-bd3cc3e595c0
# ╠═7471e01d-7b99-4000-9e53-a6e0ac83644a
# ╟─835d59cf-73ea-4d85-a4cf-27f4b04f77e3
# ╠═71b7de70-4136-48d5-9399-f07e34409dbe
# ╠═8b0b7513-1271-4519-b525-202a1f46360d
# ╠═b8b25044-e09c-4cec-a58e-92c2aadfca1d
# ╠═55640801-146a-45a6-8d74-e0ea36aac298
# ╟─aee01040-4a40-443c-be11-e42cba1ac525
# ╠═592ae9d2-5245-478f-b7e9-fbb8593ae3e7
# ╟─772b145d-e949-475a-8dce-0d9db809aa71
# ╠═42b1fafd-898d-48a4-bd9c-9e301b5af57e
# ╟─4b0d55e8-9b16-47a6-b0fd-62c8a13df7de
# ╠═b87d6a15-89e2-4f1e-9e7e-aaa541bedd7e
# ╠═5f57dbcd-cd44-4481-a6c3-f35186541b27
# ╠═f629deff-2380-439b-bafa-dfc34ac7717a
# ╠═52af5b18-b3b1-4d60-a318-817d39005027
# ╟─4d101a73-6b77-4641-ba2d-645b66d3d713
# ╠═eb4a1cea-aae1-4800-8f73-36f10af5b543
# ╟─f48d6ddb-f81a-4ee6-8eac-8bab62769070
# ╠═c0fad7ba-fd55-4b5d-bc30-87c00488ed99
# ╠═c763e519-ade6-4272-a913-d0a11cb90fa5
# ╟─e1c243f3-2b05-482d-8745-f3184e006b99
# ╠═9a605a62-5a9b-46ba-916b-07ff6672287b
# ╠═0ab826eb-1117-4b88-84a3-98cf19c976d1
# ╠═98228370-6b93-47e4-8129-caa2dbe2f485
# ╟─24995364-439e-4481-b120-e8627b58ffcc
# ╠═ac1d692e-6967-429c-b562-c2be6d4b8a63
# ╟─28d67a4b-abe8-46df-b6bb-2487dbf3e33e
# ╠═3bcfd003-5c6f-4cd8-b9f1-60769cbc3d63
# ╠═fad1b1f0-2052-43fb-9e77-f5bfb413f3e9
# ╟─24198787-92e1-47d1-af6e-1a1403f458d8
# ╠═851ed215-a8b4-41e7-9e73-36f6acf59a50
# ╟─f3076f20-e98a-483f-a06e-9cb3ff5ccfdb
# ╟─c1d5d67a-e081-4d21-a85d-7e3ecc7f2c67
# ╠═288cf2bd-d68f-4394-bc26-6286c4cd9af3
# ╠═e269a442-2416-45e5-9dd0-4d69a21f03a4
# ╠═bb40b310-6de7-4939-a547-bfddf03ffb27
# ╠═b4c712a3-ad94-42b5-9d5f-d61698603c3b
# ╠═7505024d-5a38-4ce8-9355-afb10c367751
# ╠═5cea7991-699e-4041-ab67-b9f985128007
# ╠═60f1dcaf-fcd4-4389-ba01-b02dfb1393d4
# ╠═afb44799-b4f9-4ccb-9362-0faf02ccac82
# ╟─4785c17f-d1f7-4c57-a765-66df97781833
# ╠═12201881-dd56-4316-bb0b-458cdeb758bb
# ╠═14c4cdde-e483-4ebd-a561-457e713934b7
# ╠═d8001506-4983-4738-826a-89e160f796ab
# ╟─a98cae60-8751-4c64-90f6-9583d240aa01
# ╠═5c3e8f2c-82b6-4bbd-9b10-95ba22030059
# ╠═16a75f24-6f32-4867-becf-bf99921928bd
# ╟─a62695a3-0cb5-45cf-9068-a9124a9e40cf
# ╠═d00142d9-76bd-4d08-8a28-c8f8c52a30ee
# ╟─5d79a823-d7bb-42f4-983f-dca60a3999ba
# ╠═4bd3d80c-932f-46a2-870f-99fc00f26ae7
# ╟─353eb275-3c22-492a-850a-11012004422e
# ╠═c462b1fa-bc51-4b35-aec1-804d658de957
# ╟─6c07ec9e-5fcf-495a-8759-bf743f93daa9
# ╠═ff00eba0-dd64-4f51-9746-7f848164edc3
# ╟─aa001081-ee2c-4d48-84dd-c78229f8e71c
# ╟─ab7e655d-114f-4c42-a295-b4c31119863c
# ╟─30fd63ec-0282-430b-9408-e3d77fb8aeed
# ╠═dacbdbec-a43c-47bc-9f61-b2da6cecd3d6
# ╠═173d8e66-79d9-4871-bbf5-7edd7138722e
# ╠═1c3bd18e-384b-4595-aefd-0bc60ebf1a8a
# ╠═68eea311-7d94-4fcb-a450-a9fde2651f5b
# ╟─0a9ed3d9-0366-4038-84d9-5f87e774faac
# ╟─446744c1-862d-4ca7-8546-bfb9d9634bfa
# ╠═b289b895-f9c0-4942-b43e-536700dca28b
# ╠═9c5b918f-0011-4703-b14d-af63269fbe14
# ╠═be1102d0-3a00-4a21-8731-f277fe408b01
# ╟─e9317e3d-e0f7-4a21-b74a-bfad3a64c14a
# ╠═284fda9d-0cf9-4448-9011-3de1b10d366f
# ╠═eb385960-9e51-4f24-ba5c-81ebf6d4c830
