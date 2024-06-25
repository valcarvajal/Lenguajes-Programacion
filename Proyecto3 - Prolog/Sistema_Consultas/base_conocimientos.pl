%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 													Proyecto 3													%
% 											Lenguajes de Programación											%
% 									 Sistema de diagnóstico utilizando Prolog									%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	

%===============================================================================================================%
%                     Árbol de contagios de COVID-19 en la zona de Alajuela distrito Central                    
%===============================================================================================================%

% Hechos que representan las relaciones de infección entre personas.
infects(maria,pedro).
infects(pedro,julia).
infects(julia,flor).
infects(flor,rosa).
infects(rosa,gloria).
infects(jose,flor).
infects(carlos,jose).
infects(andres,jose).

%===============================================================================================================%
% 								                      Hechos													% 
%===============================================================================================================%

% Hechos que representan condiciones y situaciones para las personas.

%------------------------------------------------------------
presenta_sintomas(true).
%------------------------------------------------------------
expuesto_al_virus(true).
%------------------------------------------------------------
incubacion_completada(true).
%------------------------------------------------------------
fuente_de_prueba_valida(autoprueba).
fuente_de_prueba_valida(centro).
%------------------------------------------------------------
tipo_de_prueba_valida(pcr).
tipo_de_prueba_valida(pa).
%------------------------------------------------------------
prueba_realizada_correctamente(true).
%------------------------------------------------------------
se_realizo_pcr(true).
%------------------------------------------------------------
se_realizo_pa(true).
%------------------------------------------------------------
infeccion_anterior(true).
%------------------------------------------------------------
positivo_ultimos_30_dias(true).
%------------------------------------------------------------
positivo_ultimos_90_dias(true).
%------------------------------------------------------------
prueba_unica(true).
%------------------------------------------------------------
transcurridas_48_horas(true).
%------------------------------------------------------------
resultado_concluyente(true).
%------------------------------------------------------------
resultado_positivo(true).
%------------------------------------------------------------
se_realizo_anticuerpos(true).
%------------------------------------------------------------
cumple_con_el_aislamiento(true).
%------------------------------------------------------------
informar_a_la_burbuja_social(true).
%------------------------------------------------------------
revisar_constantemente_los_sintomas(true).
%------------------------------------------------------------
seguir_el_tratamiento(true).
%------------------------------------------------------------
revisar_otras_enfermedades(true).
%------------------------------------------------------------
tomar_medidas_preventivas(true).
%------------------------------------------------------------

%===============================================================================================================%
% 								                      Reglas													% 
%===============================================================================================================%

% Reglas que definen diversos criterios para realizar consultas acerca del diagnóstico y tratamiento de COVID-19.

%----------------------------------------------------------------------------------------------------------------
% necesidad_prueba/3
% Entradas: Sintomas, Exposicion, Incubacion
% Salida: Verdadero si la persona necesita una prueba, falso en caso contrario
% Restricciones: No tiene restricciones.
%----------------------------------------------------------------------------------------------------------------
necesita_prueba(Sintomas,Exposicion,Incubacion) :- 
    presenta_sintomas(Sintomas);
    %or
    (expuesto_al_virus(Exposicion),
    %and
    incubacion_completada(Incubacion)).

%----------------------------------------------------------------------------------------------------------------
% necesita_una_pcr/4
% Entradas: Necesidad, Unica, Positivo_30_dias, Positivo_90_dias
% Salida: Verdadero si la persona necesita una prueba PCR, falso en caso contrario
% Restricciones: No tiene restricciones.
%----------------------------------------------------------------------------------------------------------------
necesita_una_pcr(Necesidad, Unica, Positivo_30_dias, Positivo_90_dias) :-
    necesita_prueba(Necesidad,Necesidad,Necesidad),
    %and
    prueba_unica(Unica),
    %and
    not(positivo_ultimos_30_dias(Positivo_30_dias)),
    %and
    not(positivo_ultimos_90_dias(Positivo_90_dias)).

%----------------------------------------------------------------------------------------------------------------
% necesita_una_pa/4
% Entradas: Necesidad, Unica, Positivo_30_dias, Positivo_90_dias
% Salida: Verdadero si la persona necesita una prueba de antígeno, falso en caso contrario
% Restricciones: No tiene restricciones.
%----------------------------------------------------------------------------------------------------------------
necesita_una_pa(Necesidad, Unica, Positivo_30_dias, Positivo_90_dias) :-
    necesita_prueba(Necesidad,Necesidad,Necesidad),
    %and
    (not(prueba_unica(Unica));
    %or
    positivo_ultimos_30_dias(Positivo_30_dias);
    %or
    positivo_ultimos_90_dias(Positivo_90_dias)).

%----------------------------------------------------------------------------------------------------------------
% se_realiza_pcr/2
% Entradas: Realizada, Concluyente
% Salida: Verdadero si la persona se realiza una prueba PCR concluyente, falso en caso contrario
% Restricciones: No tiene restricciones.
%----------------------------------------------------------------------------------------------------------------
se_realiza_pcr(Realizada,Concluyente) :-
    se_realizo_pcr(Realizada),
    %and
    resultado_concluyente(Concluyente).

%----------------------------------------------------------------------------------------------------------------
% se_realiza_pa/2
% Entradas: Realizada, Concluyente
% Salida: Verdadero si la persona se realiza una prueba de antígeno concluyente, falso en caso contrario
% Restricciones: No tiene restricciones.
%----------------------------------------------------------------------------------------------------------------
se_realiza_pa(Realizada,Concluyente) :-
    se_realizo_pa(Realizada),
    %and
    resultado_concluyente(Concluyente).

%----------------------------------------------------------------------------------------------------------------
% pcr_positiva/2
% Entradas: Realiza_pcr, Resultado_pcr
% Salida: Verdadero si la persona tiene una prueba PCR positiva, falso en caso contrario
% Restricciones: La persona debe necesitar una única prueba, también, debe no haber dado positivo
% en los últimos 30 a 90 días y la prueba PCR realizada debe ser concluyente y positiva.
%----------------------------------------------------------------------------------------------------------------
pcr_positiva(Realiza_pcr, Resultado_pcr) :-
    necesita_una_pcr(true, true, false, false),
    %and
    se_realiza_pcr(Realiza_pcr,Realiza_pcr),
    %and
    resultado_positivo(Resultado_pcr).

%----------------------------------------------------------------------------------------------------------------
% pcr_negativa/2
% Entradas: Realiza_pcr, Resultado_pcr
% Salida: Verdadero si la persona tiene una prueba PCR negativa, falso en caso contrario
% Restricciones: La prueba PCR no puede ser positiva.
%----------------------------------------------------------------------------------------------------------------
pcr_negativa(Realiza_pcr, Resultado_pcr) :-
    not(pcr_positiva(Realiza_pcr, Resultado_pcr)).

%----------------------------------------------------------------------------------------------------------------
% pa_negativa/7
% Entradas: Sintomas, Realiza_pa_1, Realiza_pa_2, Realiza_pa_3, Resultado_pa_1, Resultado_pa_2, Resultado_pa_3
% Salida: Verdadero si la persona tiene una prueba de antígeno negativa, falso en caso contrario
% Restricciones: La persona debe necesitar una única prueba y que no haya dado positivo en los últimos 30 a 90 días.
% Además, si presenta síntomas, la prueba debe realizarse después de 48 horas.
%----------------------------------------------------------------------------------------------------------------
pa_negativa(Sintomas, Realiza_pa_1, Realiza_pa_2, Realiza_pa_3, Resultado_pa_1, Resultado_pa_2, Resultado_pa_3) :-
    necesita_una_pa(true, false, true, true),
    %and
    se_realiza_pa(Realiza_pa_1,Realiza_pa_1),
    %and
    not(resultado_positivo(Resultado_pa_1)),
    (   
        (   
    	presenta_sintomas(Sintomas),
    	%and
    	transcurridas_48_horas(true),
    	%and
        se_realiza_pa(Realiza_pa_2,Realiza_pa_2),
        %and
        not(resultado_positivo(Resultado_pa_2))
    	);
    %or
    	(   
    	not(presenta_sintomas(Sintomas)),
    	%and
    	transcurridas_48_horas(true),
    	%and
    	se_realiza_pa(Realiza_pa_2,Realiza_pa_2),
        %and
        not(resultado_positivo(Resultado_pa_2)),
        %and
    	transcurridas_48_horas(true),
    	%and
    	se_realiza_pa(Realiza_pa_3,Realiza_pa_3),
        %and
        not(resultado_positivo(Resultado_pa_3))
    	)
    ).

%----------------------------------------------------------------------------------------------------------------
% pa_positiva/7
% Entradas: Sintomas, Realiza_pa_1, Realiza_pa_2, Realiza_pa_3, Resultado_pa_1, Resultado_pa_2, Resultado_pa_3
% Salida: Verdadero si la persona tiene una prueba de antígeno positiva, falso en caso contrario
% Restricciones: Que la persona no tenga una prueba de antígeno negativa.
%----------------------------------------------------------------------------------------------------------------
pa_positiva(Sintomas,Realiza_pa_1, Realiza_pa_2, Realiza_pa_3, Resultado_pa_1, Resultado_pa_2, Resultado_pa_3) :-
    not(pa_negativa(Sintomas, Realiza_pa_1, Realiza_pa_2, Realiza_pa_3, Resultado_pa_1, Resultado_pa_2, Resultado_pa_3)).

%----------------------------------------------------------------------------------------------------------------
% la_prueba_es_valida/3
% Entradas: Fuente_valida, Tipo_valido, Correctitud
% Salida: Verdadero si la fuente y el tipo de prueba son válidos y la prueba se realizó correctamente, falso en caso contrario
% Restricciones: La fuente y el tipo de prueba deben ser válidos y la prueba debe haberse realizado correctamente.
%----------------------------------------------------------------------------------------------------------------
la_prueba_es_valida(Fuente_valida, Tipo_valido, Correctitud) :-
    fuente_de_prueba_valida(Fuente_valida),    
    tipo_de_prueba_valida(Tipo_valido),
    prueba_realizada_correctamente(Correctitud).

%----------------------------------------------------------------------------------------------------------------
% se_encuentra_contagiado/4
% Entradas: Realiza_prueba, Resultado_prueba, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona está contagiada según los resultados de las pruebas realizadas y son válidos,
% falso en caso contrario
% Restricciones: La persona debe tener una prueba PCR positiva y una prueba de antígeno positiva, ambas válidas.
%----------------------------------------------------------------------------------------------------------------
se_encuentra_contagiado(Realiza_prueba, Resultado_prueba, Fuente_prueba, Tipo_prueba) :-
    pcr_positiva(Realiza_prueba, Resultado_prueba),
    pa_positiva(true, Realiza_prueba, Realiza_prueba, Realiza_prueba, Resultado_prueba, Resultado_prueba, Resultado_prueba),
    la_prueba_es_valida(Fuente_prueba, Tipo_prueba, true).

%----------------------------------------------------------------------------------------------------------------
% no_se_encuentra_contagiado/4
% Entradas: Realiza_prueba, Resultado_prueba, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona no está contagiada según los resultados de las pruebas realizadas y son válidos,
% falso en caso contrario
% Restricciones: La persona debe tener una prueba PCR negativa y una prueba de antígeno negativa, ambas válidas.
%----------------------------------------------------------------------------------------------------------------
no_se_encuentra_contagiado(Realiza_prueba, Resultado_prueba, Fuente_prueba, Tipo_prueba) :-
    pcr_negativa(Realiza_prueba, Resultado_prueba),
    pa_negativa(true, Realiza_prueba, Realiza_prueba, Realiza_prueba, Resultado_prueba, Resultado_prueba, Resultado_prueba),
    la_prueba_es_valida(Fuente_prueba, Tipo_prueba, true).

%----------------------------------------------------------------------------------------------------------------
% es_asintomatico/4
% Entradas: Contagiado, Sintomas, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona está contagiada pero no presenta síntomas, falso en caso contrario
% Restricciones: La persona debe estar contagiada y no presentar síntomas.
%----------------------------------------------------------------------------------------------------------------
es_asintomatico(Contagiado, Sintomas, Fuente_prueba, Tipo_prueba) :-
    se_encuentra_contagiado(Contagiado, Contagiado, Fuente_prueba, Tipo_prueba),
    not(presenta_sintomas(Sintomas)).

%----------------------------------------------------------------------------------------------------------------
% es_sintomatico/4
% Entradas: Contagiado, Sintomas, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona está contagiada y presenta síntomas, falso en caso contrario
% Restricciones: La persona debe estar contagiada y presentar síntomas.
%----------------------------------------------------------------------------------------------------------------
es_sintomatico(Contagiado, Sintomas, Fuente_prueba, Tipo_prueba) :-
    se_encuentra_contagiado(Contagiado, Contagiado, Fuente_prueba, Tipo_prueba),
    presenta_sintomas(Sintomas).

%----------------------------------------------------------------------------------------------------------------
% no_se_encuentra_contagiado_pero_presenta_sintomas/4
% Entradas: Contagiado, Sintomas, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona no está contagiada pero presenta síntomas, falso en caso contrario
% Restricciones: La persona no debe estar contagiada y debe presentar síntomas.
%----------------------------------------------------------------------------------------------------------------
no_se_encuentra_contagiado_pero_presenta_sintomas(Contagiado, Sintomas, Fuente_prueba, Tipo_prueba) :-
    no_se_encuentra_contagiado(Contagiado, Sintomas, Fuente_prueba, Tipo_prueba),
    presenta_sintomas(Sintomas).

%----------------------------------------------------------------------------------------------------------------
% debe_utilizar_una_prueba_anticuerpos/4
% Entradas: Contagiado, Anterior_infeccion, Fuente_prueba, Tipo_prueba
% Salida: Verdadero si la persona no está contagiada pero tuvo una infección previa, falso en caso contrario
% Restricciones: La persona no debe estar contagiada y debe tener una infección anterior.
%----------------------------------------------------------------------------------------------------------------
debe_utilizar_una_prueba_anticuerpos(Contagiado, Anterior_infeccion, Fuente_prueba, Tipo_prueba):-
    no_se_encuentra_contagiado(Contagiado, Anterior_infeccion, Fuente_prueba, Tipo_prueba),
    infeccion_anterior(Anterior_infeccion).

%----------------------------------------------------------------------------------------------------------------
% prueba_anticuerpos_positiva/2
% Entradas: Realizo_anticuerpos, Resultado_anticuerpos
% Salida: Verdadero si la persona tiene una prueba de anticuerpos positiva, falso en caso contrario
% Restricciones: La persona debe haberse realizado una prueba de anticuerpos y el resultado debe ser positivo.
%----------------------------------------------------------------------------------------------------------------
prueba_anticuerpos_positiva(Realizo_anticuerpos, Resultado_anticuerpos) :-
    se_realizo_anticuerpos(Realizo_anticuerpos),
    resultado_positivo(Resultado_anticuerpos).

%----------------------------------------------------------------------------------------------------------------
% sigue_el_protocolo_para_contagiados/4
% Entradas: Aislamiento, Informar, Revisar_sintomas, Tratamiento
% Salida: Verdadero si la persona sigue el protocolo recomendado para los contagiados, falso en caso contrario
% Restricciones: La persona debe cumplir con el aislamiento, informar a su burbuja social,
% revisar constantemente los síntomas y seguir el tratamiento.
%----------------------------------------------------------------------------------------------------------------
sigue_el_protocolo_para_contagiados(Aislamiento, Informar, Revisar_sintomas, Tratamiento) :-
    cumple_con_el_aislamiento(Aislamiento),
	informar_a_la_burbuja_social( Informar),
	revisar_constantemente_los_sintomas(Revisar_sintomas),
	seguir_el_tratamiento(Tratamiento).

%----------------------------------------------------------------------------------------------------------------
% sigue_el_protocolo_para_no_contagiados/0
% Entradas: -
% Salida: Verdadero si la persona sigue el protocolo recomendado para los no contagiados, falso en caso contrario
% Restricciones: La persona debe revisar por otras enfermedades y tomar medidas preventivas.
%----------------------------------------------------------------------------------------------------------------
sigue_el_protocolo_para_no_contagiados() :-
    revisar_otras_enfermedades(true),
	tomar_medidas_preventivas(true).

%----------------------------------------------------------------------------------------------------------------
% diagnostico/2
% Entradas: Persona, Resultado
% Salida: Verdadero si la persona está contagiada según el árbol de contagios, falso en caso contrario
% Restricciones: La persona debe tener una relación de infección con otra persona en el árbol de contagios definido.
%----------------------------------------------------------------------------------------------------------------
diagnostico(Persona, positivo) :-
    infects(Persona, _);
    infects(_, Persona).

diagnostico(Persona, negativo) :-
    + infects(Persona, _),
    + infects(_, Persona).

%----------------------------------------------------------------------------------------------------------------
% spread_disease/2
% Entradas: Enfermo, Contagiado
% Salida: Verdadero si hay una cadena de contagio desde Enfermo hasta Contagiado, falso en caso contrario
% Restricciones: La relación de infección debe existir entre personas de manera directa o indirecta para
% establecer la cadena de contagio.
%----------------------------------------------------------------------------------------------------------------
spread_disease(Paciente, Contagiados) :-
    spread_disease_aux(Paciente, [], Contagiados).

spread_disease_aux(Paciente, ContagiadosActuales, Contagiados) :-
    infects(Paciente, X), % Verifica si Paciente contagió a X
    \+ member(X, ContagiadosActuales), % Asegura que X no esté en la lista de contagiados actuales
    spread_disease_aux(X, [X | ContagiadosActuales], Contagiados). % Llamada recursiva

spread_disease_aux(_, Contagiados, Contagiados).


%----------------------------------------------------------------------------------------------------------------
%                                    Descripción de Cómo se Ejecuta el Código                                    
%----------------------------------------------------------------------------------------------------------------

% Descripción clara de cómo se ejecuta el código, incluyendo ejemplos.

%----------------------------------------------------------------------------------------------------------------
% Para utilizar este sistema de diagnóstico, se pueden realizar consultas basadas en las reglas definidas.
% Aquí hay algunos ejemplos de consultas y sus resultados esperados:

% Consulta para la regla necesita_prueba/3:
% ?- necesita_prueba(false, true, true).

% Consulta para la regla necesita_una_pcr/4:
% ?- necesita_una_pcr(true, true, false, false).

% Consulta para la regla necesita_una_pa/4:
% ?- necesita_una_pa(false, false, true, true).

% Consulta para la regla se_realiza_pcr/2:
% ?- se_realiza_pcr(true, false).

% Consulta para la regla se_realiza_pa/2:
% ?- se_realiza_pa(true, true).

% Consulta para la regla pcr_positiva/2:
% ?- pcr_positiva(true, false).

% Consulta para la regla pcr_negativa/2:
% ?- pcr_negativa(true, false).

% Consulta para la regla pa_negativa/7:
% ?- pa_negativa(true, true, true, false, true, false, true).

% Consulta para la regla pa_positiva/7:
% ?- pa_positiva(true, true, true, false, true, false, true).

% Consulta para la regla la_prueba_es_valida/3:
% ?- la_prueba_es_valida(autoprueba, pcr, true).

% Consulta para la regla se_encuentra_contagiado/3:
% ?- se_encuentra_contagiado(true, true, true).

% Consulta para la regla no_se_encuentra_contagiado/3:
% ?- no_se_encuentra_contagiado(true, false, true).

% Consulta para la regla es_asintomatico/2:
% ?- es_asintomatico(true, false, autoprueba, pcr).

% Consulta para la regla es_sintomatico/2:
% ?- es_sintomatico(true, false, autoprueba, pcr).

% Consulta para la regla no_se_encuentra_contagiado_pero_presenta_sintomas/2:
% ?- no_se_encuentra_contagiado_pero_presenta_sintomas(true, true, centro, pa).

% Consulta para la regla debe_utilizar_una_prueba_anticuerpos/2:
% ?- debe_utilizar_una_prueba_anticuerpos(false, true, autoprueba, pcr).

% Consulta para la regla prueba_anticuerpos_positiva/2:
% ?- prueba_anticuerpos_positiva(true, true).

% Consulta para la regla sigue_el_protocolo_para_contagiados/4:
% ?- sigue_el_protocolo_para_contagiados(true, true, true, true).

% Consulta para la regla sigue_el_protocolo_para_no_contagiados/0:
% ?- sigue_el_protocolo_para_no_contagiados().

% Consulta para la regla diagnostico/2:
% ?- diagnostico(jose, positivo).

% Consulta para la regla spread_disease/2:
% ?- spread_disease(maria, Contagiados).
%----------------------------------------------------------------------------------------------------------------
