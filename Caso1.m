(* ::Package:: *)

(* ::Title:: *)
(*Caso 1 : Practica de teor\[IAcute]a de colas*)


(* ::Subtitle:: *)
(*Parte primera*)


(* ::Subsubtitle:: *)
(*a) Generador Congruencial Mixto*)


(* ::Input:: *)
(*a= 314159269;*)
(*c= 453806245;*)
(*m=2^31;*)
(**)


(* ::Text:: *)
(*Generador de valores aleatorios con distribuci\[OAcute]n uniforme*)


(* ::Input:: *)
(*Module[{varstatic=0},RandomData[]:= (varstatic= Mod[(314159269*varstatic+453806245),2^31])/2^31];*)
(**)


(* ::Input:: *)
(*RandomData[] //N*)


(* ::Subsubtitle:: *)
(*b) Prueba del RandomData*)


(* ::Input:: *)
(*Histogram[Table[RandomData[],{10000}]]*)


(* ::Subsubtitle:: *)
(*c) Metodo de transformada inversa*)


(* ::Text:: *)
(*Generador de valores aleatorios con distribuci\[OAcute]n exponencial a partir del generador aleatorio. El tiempo entre llegadas sera x tal que x = ((- 1)/landa)*Ln (u) donde u es una variable aleatoria de distribuci\[OAcute]n uniforme.*)
(*   *)


(* ::Text:: *)
(*CDF es la funcion acumulativa de probabilidad. Te da la probabilidad de que haya un elemento por debajo de la gr\[AAcute]fica dibujada. Por eso tendiendo a infinito, la probabilidad es 1, porque es la probabilidad de que estemos por debajo de infinito. La PDF es Probability Density Fucntion, es la diferencial de probabilidad entre la dif de la variable, en este caso tiempo.Para el valor t = 0 tenemos que f (x) es landa. ES la probabilidad de que lleguen paquetes por debajo de ese tiempo.*)


(* ::Input:: *)
(*RandomExp[Lambda_]:= -1/Lambda*Log[RandomData[]]*)


(* ::Input:: *)
(*Histogram[Table[RandomExp[10000],{10000}],"CFD"]*)


(* ::Input:: *)
(*Histogram[Table[RandomExp[10000],{10000}],"PDF"]*)


(* ::Subtitle:: *)
(*Parte segunda*)


(* ::Subsubtitle:: *)
(*a) Cola M/M/1*)


(* ::Text:: *)
(*Sea landa la tasa de llegadas y mu la tasa de servicio , nmax es el numero maximo de llegadas:*)


(* ::Input:: *)
(*nmax=1000;*)


(* ::Input:: *)
(*lambda=100;*)


(* ::Input:: *)
(*mu=101;*)


(* ::Text:: *)
(*El tiempo entre llegadas es exponencial :*)


(* ::Input:: *)
(*InterArrivalsTime[lambda_]:= Table[RandomExp[lambda],{1000}]//N;*)


(* ::Input:: *)
(*tiemposEntreLlegadas=InterArrivalsTime[lambda];*)


(* ::Input:: *)
(*serviceTime[mu_]:= Table[(RandomExp[mu]),{nmax}]//N;*)


(* ::Input:: *)
(*tiempoServicio=serviceTime[mu] ;*)


(* ::Text:: *)
(*A continuaci\[OAcute]n se crea una funci\[OAcute]n que devuelve los tiempos de las llegadas con respecto al origen, y no con respecto a la anterior llegada.*)


(* ::Input:: *)
(**)


(* ::Input:: *)
(*Module[{t=0},*)
(*AcumSeries[landa_]:=Map[(t += #)&,tiemposEntreLlegadas]];*)


(* ::Input:: *)
(*tiempoDeLlegada=AcumSeries[lambda];*)


(* ::Input:: *)
(*FifoSchedulling[arrivals_,service_]:=Module[{n,checkTime},n=1;checkTime=arrivals[[1]];*)
(*(If[checkTime>=#,checkTime+=service[[n++]],checkTime=#+service[[n++]]])&/@arrivals];*)
(**)


(* ::Input:: *)
(*departuresTime= FifoSchedulling[tiemposEntreLlegadas,tiempoServicio];*)


(* ::Input:: *)
(*ListPlot[{tiempoDeLlegada,departuresTime},PlotStyle->{Blue, Red}]*)


(* ::Text:: *)
(*El module lleva el control de en que escalon estamos. El map devuelve la coordenada x, y del punto de arriba y la x, y del punto de abajo.*)


(* ::Input:: *)
(*PointStairStep2[arrivalsTime_]:= Module[{e=0},Flatten[Map[({{ #,e},{#,e+=1}})&,arrivalsTime],1]]*)


(* ::Input:: *)
(*arrivalsStairStep=PointStairStep2[tiempoDeLlegada];*)


(* ::Input:: *)
(*departuresStairStep= PointStairStep2[departuresTime];*)


(* ::Input:: *)
(*ListPlot[{arrivalsStairStep,departuresStairStep},PlotStyle->{Blue, Red}]*)


(* ::Input:: *)
(*minwith=10;maxwith=1000;*)


(* ::Input:: *)
(*Manipulate[ListLinePlot[{arrivalsStairStep[[origen;;origen+with]],departuresStairStep[[origen;;origen+with]]},PlotStyle->{Blue,Red}],{origen,1,nmax,1},{with,minwith,maxwith,1}]*)


(* ::Input:: *)
(*Plot[1/(1-ro),{ro,0,1},AxesOrigin ->{0,0}]*)
