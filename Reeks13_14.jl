### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d6788779-fc9f-431c-b247-6f9da302fc00
using Pkg #de Pkg package stelt ons in staat om binnen Julia packages te installeren

# ╔═╡ 22410d92-2b7e-4a3f-8190-79b5562b4289
using Plots #Julia heeft een aantal Plot packages, voorlopig lijkt "Plots" de interessantste, maar "Makie" is ook interessant. Plots is wel berucht om zijn trage opstarttijd.

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
In deze reeks bekijken we een aantal voorbeeldprogramma's in Julia.
"

# ╔═╡ 0269c3bc-0c2e-4095-ac9b-af62429f74ec
md"#### Elementaire functies en terminal output
Het volgende programma demonstreert een aantal elementaire functies in Julia. Om de output van alle operaties te tonen, maken we gebruik van een `with_terminal() do ... end` blok, waarbinnen we de `println` functie gebruiken om resultaten weer te geven. In toekomstige versies van Pluto zal het weergeven van outputs met het `@info` macro gebeuren."

# ╔═╡ 95996e61-4511-4fa9-88c6-a08b895359fa
md"Als de volgende cel een error geeft, is dat omdat je `PlutoUI` nog niet hebt geïnstalleerd. `PlutoUI` is nodig om de terminal outputs weer te geven. Maak een nieuwe cel aan waarin je eerst `PlutoUI` installeert en vervolgens importeert."

# ╔═╡ c6b4bdd7-8158-417c-92d6-5e1507228415


# ╔═╡ 21a88921-8740-439e-8069-112d79014d2a
with_terminal() do
	println("sqrt(25) = ", sqrt(25))
	println("cbrt(64) = ", cbrt(64))
	println("exp(10) = ", exp(10))
	println("log2(64) = ", log2(64))
	println("log10(1000): ", log10(1000))
	println("log(exp(4)): ", log(exp(4)))
	println("conj(8 - 5im): ", conj(8 - 5im))
	println("abs(3 + 4im): ", abs(3 + 4im))
	println("angle(3 + 4im): ", angle(3 + 4im))
	println("abs(3 + 4im) * exp(angle(3+4im)im): ", abs(3 + 4im) * exp(angle(3+4im)im))
	println("24÷5 = ", 24÷5)
	println("24/5 = ", 24/5)
end

# ╔═╡ 632d10c5-bd00-464d-bd56-8b899af525ef
md"#### Matrix slicing en puntsgewijze assignments
Het volgende programma definieert een matrix en manipuleert die vervolgens. Om alle stappen van het programma te begrijpen kun je opnieuw een `with_terminal()` blok gebruiken, of alle lijnen na lijn ``n`` wegcommentariëren zodat de ``n``de lijn de laatste expressie is binnen het `let` blok.
"


# ╔═╡ 97a081f0-f0c6-48f2-ae4e-8e3ff5b99ff4
#TODO

# ╔═╡ 72d0417c-de29-4b2a-af89-c74016fbf6ad
md"#### Handige matrix functies

"

# ╔═╡ b06f3f6c-d038-4fa2-b675-8ede7e6348b6


# ╔═╡ 7b01db27-3dd4-42e6-b4aa-442d2266670e
md"#### Kortere oneline functies met de ternary operator

"

# ╔═╡ a1587fd5-8f49-42d5-a1b8-51d62d56c892


# ╔═╡ 5f37de56-bb6e-4811-9160-99f1b63e0875
md"#### List comprehensions

"

# ╔═╡ 63bcdad7-c80d-4e41-91f1-44a7642de620


# ╔═╡ f5c595b2-c48a-4373-960b-9aa25d70dc55
md"#### De ingebouwde `sum` en `prod` functies

"

# ╔═╡ 0a9c54bb-682b-48b1-9b38-a95b63e523d1


# ╔═╡ c83f7804-a5ea-4bcf-b2c8-4b0f6e4f35c5
md"#### Strings

"

# ╔═╡ 76d22458-b22e-4af9-9edb-bf0f6b855e35


# ╔═╡ bbe81be5-e34d-4696-9696-d738b2113f85
md"#### Relationele en logische operatoren

"

# ╔═╡ dd70c88b-32b7-4ca9-8a9e-f9eea8489f92


# ╔═╡ 8c6880e4-32ec-4a5e-a29c-20120fa31fe6
md"#### For loops

"

# ╔═╡ b8b25044-e09c-4cec-a58e-92c2aadfca1d


# ╔═╡ 4d101a73-6b77-4641-ba2d-645b66d3d713
md"#### Functies

"

# ╔═╡ 0ab826eb-1117-4b88-84a3-98cf19c976d1


# ╔═╡ a98cae60-8751-4c64-90f6-9583d240aa01
md"#### Pipes

"

# ╔═╡ 16a75f24-6f32-4867-becf-bf99921928bd


# ╔═╡ 4b0d55e8-9b16-47a6-b0fd-62c8a13df7de
md"#### Recursieve functies
Fibonacci

"

# ╔═╡ 6194ef1d-65da-46f1-8bea-4c2db39a6c66


# ╔═╡ 9e0a24ac-9cd5-48eb-bc31-9e73a81256cb


# ╔═╡ 30fd63ec-0282-430b-9408-e3d77fb8aeed
md"#### Timing en benchmarking

"

# ╔═╡ b289b895-f9c0-4942-b43e-536700dca28b


# ╔═╡ 9c5b918f-0011-4703-b14d-af63269fbe14


# ╔═╡ Cell order:
# ╟─065f9b00-ce70-11eb-1ee1-5d39cf5e39fc
# ╟─c5d21e48-12e1-49e0-b1ac-1695c18fc7f2
# ╟─47a2c712-dc44-4ff4-bdf6-0d78178812cb
# ╟─b868460c-f229-4d0a-ac98-42e76cad1a1b
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
# ╠═4b96e09f-e9b0-4551-816d-d930b497deba
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
# ╟─0269c3bc-0c2e-4095-ac9b-af62429f74ec
# ╠═95996e61-4511-4fa9-88c6-a08b895359fa
# ╠═c6b4bdd7-8158-417c-92d6-5e1507228415
# ╠═21a88921-8740-439e-8069-112d79014d2a
# ╠═632d10c5-bd00-464d-bd56-8b899af525ef
# ╠═97a081f0-f0c6-48f2-ae4e-8e3ff5b99ff4
# ╠═72d0417c-de29-4b2a-af89-c74016fbf6ad
# ╠═b06f3f6c-d038-4fa2-b675-8ede7e6348b6
# ╠═7b01db27-3dd4-42e6-b4aa-442d2266670e
# ╠═a1587fd5-8f49-42d5-a1b8-51d62d56c892
# ╠═5f37de56-bb6e-4811-9160-99f1b63e0875
# ╠═63bcdad7-c80d-4e41-91f1-44a7642de620
# ╠═f5c595b2-c48a-4373-960b-9aa25d70dc55
# ╠═0a9c54bb-682b-48b1-9b38-a95b63e523d1
# ╠═c83f7804-a5ea-4bcf-b2c8-4b0f6e4f35c5
# ╠═76d22458-b22e-4af9-9edb-bf0f6b855e35
# ╠═bbe81be5-e34d-4696-9696-d738b2113f85
# ╠═dd70c88b-32b7-4ca9-8a9e-f9eea8489f92
# ╠═8c6880e4-32ec-4a5e-a29c-20120fa31fe6
# ╠═b8b25044-e09c-4cec-a58e-92c2aadfca1d
# ╠═4d101a73-6b77-4641-ba2d-645b66d3d713
# ╠═0ab826eb-1117-4b88-84a3-98cf19c976d1
# ╠═a98cae60-8751-4c64-90f6-9583d240aa01
# ╠═16a75f24-6f32-4867-becf-bf99921928bd
# ╠═4b0d55e8-9b16-47a6-b0fd-62c8a13df7de
# ╠═6194ef1d-65da-46f1-8bea-4c2db39a6c66
# ╠═9e0a24ac-9cd5-48eb-bc31-9e73a81256cb
# ╠═30fd63ec-0282-430b-9408-e3d77fb8aeed
# ╠═b289b895-f9c0-4942-b43e-536700dca28b
# ╠═9c5b918f-0011-4703-b14d-af63269fbe14
