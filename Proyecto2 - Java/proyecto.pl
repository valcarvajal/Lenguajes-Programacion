% Proyecto 3

% Hechos

% Al hacerse la prueba de detecci n:
% Recuerde hac rsela en el momento correcto
momento(correcto).

% Elija el tipo correcto de prueba seg n su circunstancia
tipo(correcto).

% Siga las instrucciones de la prueba seg n las recomendaciones de la FDA
ejecucion(correcto).


% Hay dos tipos principales de pruebas virales:
% Las pruebas de reacci n en cadena de la polimerasa (PCR)
prueba(pcr).

% Las pruebas de ant genos
prueba(antigenos).


% La muestra ser  tomada por un proveedor de atenci n m dica y ser  enviada a un laboratorio para su an lisis.
pcr_etapa_1(muestreo_exitoso).

% Prueba de amplificaci n de  cido nucleico (NAAT).
pcr_etapa_2(naat_exitoso).

% Resultado
pcr_etapa_3(resultado_positivo).

% Realizar primera prueba.
antigenos_p1_1(muestreo_exitoso).
antigenos_p1_2(resultado_positivo).

% Para estar seguro de que no tiene COVID-19, la FDA recomienda tener 2 pruebas de ant genos negativas para las personas con s ntomas.
antigenos_p2_1(muestreo_exitoso).
antigenos_p2_2(resultado_positivo).

% O 3 pruebas de ant genos para las personas sin s ntomas. 
antigenos_p3_1(muestreo_exitoso).
antigenos_p3_2(resultado_positivo).
asintomatico(verdadero).

% Realizadas con 48 horas de diferencia.
horas_transcurridas(48).

% Si no tiene s ntomas y ha estado expuesto al virus
expuesto_al_virus(verdadero).

% Las pruebas pueden ser  tiles incluso cuando no se tienen s ntomas ni hubo una exposici n reciente al COVID-19, como antes de asistir a un evento
asistir_evento_proximo(verdadero).

% o de visitar a alguien con mayor riesgo.
visita_a_persona_mayor_riesgo(verdadero).

% Si solo va a realizarse una  nica prueba, es m s confiable el resultado negativo de la prueba de PCR.
cantidad_pruebas_que_desea_realizarse(1).

% Tuve un resultado positivo para COVID-19 en los  ltimos 90 d as.
tuve_covid(verdadero).
prueba_positiva_ultimos_90dias(verdadero).

% Mi primer resultado positivo fue en los  ltimos: 30 d as o menos
primer_resultado_positivo_0a30_dias(verdadero).

% Mi primer resultado positivo fue en los  ltimos:31 a 90 d as
primer_resultado_positivo_31a90_dias(verdadero).

aislarse(cumplido).

informar(cumplido).

revisar_sintomas(cumplido).

tratamiento(cumplido).

revisar_otras_enfermedades(verdadero).

tomar_medidas_preventivas(verdadero).



% Reglas

% Al hacerse la prueba de detecci n:
resultado_real(A, B, C) :- momento(A), tipo(B), ejecucion(C).

% Hay dos tipos principales de pruebas virales:
prueba_valida(X) :- prueba(X).

realizar_pcr(A, B, C) :- pcr_etapa_1(A), pcr_etapa_2(B), pcr_etapa_3(C).

realizar_antigenos_p1(A, B) :- antigenos_p1_1(A), antigenos_p1_2(B).

esperar_proxima_antigenos_1(X, Y, Z) :- horas_transcurridas(X), not(realizar_antigenos_p1(Y,Z)).

realizar_antigenos_p2(A, B, C, D, E) :- antigenos_p2_1(A), antigenos_p2_2(B), esperar_proxima_antigenos_1(C, D, E).

esperar_proxima_antigenos_2(A, B, C, D, E, F, G) :- horas_transcurridas(A), asintomatico(B), not(realizar_antigenos_p2(C, D, E, F, G)).

realizar_antigenos_p3(A, B, C, D, E, F, G, H, I) :- antigenos_p3_1(A), antigenos_p3_2(B), esperar_proxima_antigenos_2(C, D, E, F, G, H, I).

% Cu ndo hacerse una prueba de detecci n del COVID-19
% Si tiene s ntomas, h gase una prueba inmediatamente.
realizar_inmediato(A) :- not(asintomatico(A)).

% Si no tiene s ntomas y ha estado expuesto al virus que causa el COVID-19, espere al menos 5 d as completos despu s de la exposici n antes de realizarse una prueba.
realizar_en_5dias(A, B) :- asintomatico(A), expuesto_al_virus(B).

% En qu  casos realizar si no presenta s ntomas.
recomendado_realizarse_prueba(A, B, C) :- asintomatico(A), (asistir_evento_proximo(B); visita_a_persona_mayor_riesgo(C)).


% C mo elegir una prueba de detecci n del COVID-19
% Si solo va a realizarse una  nica prueba, es m s confiable el resultado negativo de la prueba de PCR.
% No tuve COVID-19 o no tuve una prueba positiva en los  ltimos 90 d as. Usted puede optar por una prueba de ant genos o PCR.
elegir_pcr(A, B, C, D) :- cantidad_pruebas_que_desea_realizarse(A); not(antigenos_p1_2(B)); not(tuve_covid(C)); not(prueba_positiva_ultimos_90dias(D)).

% Si su prueba de ant genos arroja un resultado negativo, h gase otra prueba de ant genos despu s de 48 horas o h gase una prueba de PCR apenas pueda. primer_resultado_positivo_0a30_dias primer_resultado_positivo_31a90_dias
% Si la segunda prueba de ant genos tambi n da negativo, espere otras 48 horas y real cese una tercera prueba.
% Tuve un resultado positivo para COVID-19 en los  ltimos 90 d as.

elegir_antigenos1(A) :- not(cantidad_pruebas_que_desea_realizarse(A)).
elegir_antigenos2(B) :- not(cantidad_pruebas_que_desea_realizarse(B)).
elegir_antigenos3(C) :- not(cantidad_pruebas_que_desea_realizarse(C)).
elegir_antigenos4(D,E,F,G) :- (prueba_positiva_ultimos_90dias(D), (not(asintomatico(E)), (primer_resultado_positivo_0a30_dias(F); primer_resultado_positivo_31a90_dias(G)))).
elegir_antigenos5(H,I) :- (primer_resultado_positivo_31a90_dias(H), asintomatico(I)).

elegir_antigenos(A, B, C, D, E, F, G, H, I) :- elegir_antigenos1(A); elegir_antigenos2(B); elegir_antigenos3(C); elegir_antigenos4(D,E,F,G); elegir_antigenos5(H,I).


contagio_positivo(A,B,C,D,E,F) :- (antigenos_p1_2(A); antigenos_p2_2(B); antigenos_p3_3(C);realizar_pcr(D, E, F)).

contagio_negativo(A,B,C,D,E,F) :- not(contagio_positivo(A,B,C,D,E,F)).

protocolo_contagio_positivo(A,B,C,D,E,F,G,H,I,J) :- contagio_positivo(A,B,C,D,E,F), aislarse(G), informar(H), revisar_sintomas(I), tratamiento(J).

negativo_asintomatico(A,B,C,D,E,F,G,I) :- contagio_negativo(A,B,C,D,E,F), asintomatico(G), tomar_medidas_preventivas(I).

negativo_sintomatico(A,B,C,D,E,F,G,H,I) :- contagio_negativo(A,B,C,D,E,F), not(asintomatico(G)), revisar_otras_enfermedades(H), tomar_medidas_preventivas(I).

