### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ d6788779-fc9f-431c-b247-6f9da302fc00
using Pkg #de Pkg package stelt ons in staat om binnen Julia packages te installeren

# ╔═╡ 22410d92-2b7e-4a3f-8190-79b5562b4289
using Plots

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

# ╔═╡ bfbfc377-0f11-4f86-8f30-1737f98b82c8
md"#### Plotten
De `plot` functie is geen onderdeel van de Julia standaard bibliotheek. Daarom moeten we de `Plots` package installeren en importeren. Daarom importeren we eerst de `Pkg` package. Dat is de package om andere packages mee te installeren, zoals Internet Explorer de browser is waarmee je andere browsers installeert."

# ╔═╡ 96bb54fd-cced-42ae-bc9a-2935617ffe48
md"Voer de code in de onderstaande cel uit om `Plots` te installeren. In de daaropvolgende cel proberen we `Plots` al te importeren. Merk op dat dit een error oplevert. Merk ook op dat de error ons de juiste oplossing suggereert."

# ╔═╡ a2bddf16-b6c3-4b09-9729-1ec6e7b1f073
#Pkg.add("Plots")

# ╔═╡ ca2b793d-e1de-49d1-9eaf-dad22916f433
md"TODO"

# ╔═╡ ffa0ff53-4088-4e32-9c84-5e8997db6f5e


# ╔═╡ 0e72912f-c662-411a-81c0-4f0afd323f4a


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

# ╔═╡ 7a8ab28c-7d9e-4e43-91bd-38ade4cf77ed


# ╔═╡ 16a4cb60-3cfa-4f50-b0a1-f782252b1556
md"Dit werkt natuurlijk ook met matrices. Probeer `M` puntsgewijs met zichzelf te vermenigvuldigen."

# ╔═╡ cd1aa28d-ecc4-47cc-8d0c-074e68f699b3


# ╔═╡ 51645a3c-51b8-47a7-b2dc-2bcdd356ca37


# ╔═╡ 9cd2914a-e540-4131-8606-3533aaa16887


# ╔═╡ 7b766daf-f703-4dfd-a09c-c7439078574a
md"## Reeks 14

"

# ╔═╡ 0269c3bc-0c2e-4095-ac9b-af62429f74ec


# ╔═╡ 21a88921-8740-439e-8069-112d79014d2a


# ╔═╡ Cell order:
# ╟─065f9b00-ce70-11eb-1ee1-5d39cf5e39fc
# ╠═c5d21e48-12e1-49e0-b1ac-1695c18fc7f2
# ╠═47a2c712-dc44-4ff4-bdf6-0d78178812cb
# ╠═b868460c-f229-4d0a-ac98-42e76cad1a1b
# ╠═301dfceb-77d6-4c35-b62a-ffbdb63133d7
# ╠═250be0f8-db4b-48c5-8d96-f64acfd012d6
# ╠═4a0c5464-12aa-4e44-bdcc-bc0facab94a7
# ╠═278ab1cf-9935-4eb5-afdf-65d98295491b
# ╠═e39d5f41-5df8-43d3-bda0-990860dac893
# ╠═e666713a-e983-4435-949e-15fda6d89da0
# ╠═5a96d25f-3a80-484c-89eb-0a5d7cd31b95
# ╠═2450a720-7ba4-4fec-83a9-3f4cfb4fdc78
# ╠═31aa20a2-cf79-4c04-af18-62ce498b94da
# ╠═1c6f70a5-f39e-4667-ae70-d545f138720b
# ╠═a25aeab8-e9ba-41bd-b0d1-f2754166d2a3
# ╠═f59c258f-21e8-43ac-ad5c-7eec51da6a57
# ╠═14bfc8ae-c5b8-43d4-a628-595693dd2832
# ╠═8c703f1c-43ae-407a-b62f-d1999ff34caa
# ╠═bfcab42a-1342-476c-9087-a0c7d7c2f492
# ╠═c337d274-abe1-4cfe-ac87-294b80075330
# ╠═4d3420dd-26ce-4d0e-af5b-50b1e6b87c5a
# ╠═76a41e87-64df-4d07-9516-7ffd4796b258
# ╠═a111340d-c2b1-4c38-be08-7de3a60488ae
# ╠═ac737b66-2c3f-45bb-bd75-22053e9e5802
# ╠═7218f1f9-79cd-4f09-9062-4e4067ab8907
# ╠═023f4cec-a9d8-4917-bd3a-82671810b7dc
# ╠═3ca36760-70e7-420c-99af-fa5be4f05e56
# ╠═41dc1743-ec11-49f1-b9c6-adc3aa472cbd
# ╠═4f940fb4-137f-4b04-bb0d-920aa2c2ec74
# ╠═d3c4b019-b840-44ad-abe3-eeef6c1442f5
# ╠═08b75692-7668-4871-ae68-27e0f3ade957
# ╠═94c4d137-cf34-4481-9a9d-0747e9a0d963
# ╠═753d2408-7c51-41dc-8c4c-eb7e11f0d8bb
# ╠═2e821c0e-39fd-4bd4-a5bc-b746057581aa
# ╠═bfbfc377-0f11-4f86-8f30-1737f98b82c8
# ╠═d6788779-fc9f-431c-b247-6f9da302fc00
# ╠═96bb54fd-cced-42ae-bc9a-2935617ffe48
# ╠═a2bddf16-b6c3-4b09-9729-1ec6e7b1f073
# ╠═22410d92-2b7e-4a3f-8190-79b5562b4289
# ╠═ca2b793d-e1de-49d1-9eaf-dad22916f433
# ╠═ffa0ff53-4088-4e32-9c84-5e8997db6f5e
# ╠═0e72912f-c662-411a-81c0-4f0afd323f4a
# ╠═0c226ac3-b287-44f7-b8b9-dfdee33f1664
# ╠═33d6b3e1-15aa-486a-9430-9cf50b770f89
# ╠═5cacc4bf-5d33-4e34-a6cc-c29d4099c7a7
# ╠═a3c7c7db-7ad5-4f90-a13e-d8c645091c56
# ╠═a1b3e668-e1e9-443f-90e9-2dc48bb78808
# ╠═8366c38f-8bcd-474e-a126-d03d91874a05
# ╠═75e789f0-080d-47ab-9814-c42e544c8be5
# ╠═cfeebf19-6524-4ab5-a785-59821858c154
# ╠═a6e03bc3-5dbc-4dca-9a99-94d6c76e86af
# ╠═0b3c812a-a8bf-48ba-96a7-694647cdd3c9
# ╠═46f841eb-b35e-4095-b9eb-61538aa56ff8
# ╠═7036709e-8cd3-43c8-9125-38a7aaecce19
# ╠═b080a19d-8193-48ec-98c6-a5adce99f689
# ╠═26a802e8-8df6-46e4-b087-b3db84645eed
# ╠═500826c8-7089-42f6-8f40-8e3aa01de986
# ╠═7b75f643-9eff-436e-8745-4479b1861ea7
# ╠═de7c2a28-25b3-49d4-a848-6eced7a4afc2
# ╠═0f57884d-9ebe-4354-a133-f4b9266565a5
# ╠═9d1139bd-3c58-4e5e-a09f-e88cc02a3a28
# ╠═7a8ab28c-7d9e-4e43-91bd-38ade4cf77ed
# ╠═16a4cb60-3cfa-4f50-b0a1-f782252b1556
# ╠═cd1aa28d-ecc4-47cc-8d0c-074e68f699b3
# ╠═51645a3c-51b8-47a7-b2dc-2bcdd356ca37
# ╠═9cd2914a-e540-4131-8606-3533aaa16887
# ╠═7b766daf-f703-4dfd-a09c-c7439078574a
# ╠═0269c3bc-0c2e-4095-ac9b-af62429f74ec
# ╠═21a88921-8740-439e-8069-112d79014d2a
