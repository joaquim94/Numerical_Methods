README: Resum dels arxius adjunts.
-step_heun.m: Funció que calcula un pas del mètode de Heun.

-new_stepsize_heun.m: Funció que calcula el pas a donar pel mètode de dividir el pas.

-method_heun.m: Funció que implementa les dues anteriors en un bucle.
Imita la sintaxi d'entrada i sortida de la funció ode45 del Matlab. S'assegura de calcular la funció en l'últim punt. La tolerància 
per defecte (es pot donar com a 0) és 1e-6. Afegeix la sortida "passos", el vector de passos usats.

-step_DOPRI45.m: Funció que calcula un pas del mètode de Dormand i Price. L'últim argument (ordre)
 permet seleccionar el mètode que es vol fer servir: cal indicar 4 o 5.

-new_stepsize_DOPRI45.m: Funció que calcula el pas a donar a partir de les dades locals.
Hi hem afegit una comprovació pel cas en que el pas anterior sigui "massa precís", fent que el 
substitueixi per 0.1 i després iteri per refinar-lo. Tant la tolerància inferior com el pas a 
substituir són totalment arbitraris, i poden canviar-se (en els casos provats han funcionat bé).

-method_DOPRI45.m: Funció que implementa les dues anteriors en un bucle. Imita també la sintaxi 
de la funció ode45 de Matlab. S'assegura de calcular la funció en l'últim punt. La tolerància 
per defecte (es pot donar com a 0) és 1e-6.

-DOPRI45.m: Funció que implementa step_DOPRI45.m i new_stepsizeDOPRI45.m en bucle, amb una opció addicional: 
el vector d'entrada T0 ja no és necessàriament de dues components: la funció pot calcular la solució en 
punts donats (és més aviat un experiment, sembla que funciona en tots els casos provats reajustant apropiadament 
el pas sempre que cal).

-representa.m: funció que dibuixa les trajectòries físiques pel problema de força central donat. Cal donar com a 
arguments la velocitat inicial en direcció v0, la tolerància i el pas inicial. No genera sortida, només fa un plot. 
La línia del mètode de Heun està comentada, pot descomentar-se (i comentar la línia del mètode de DOPRI45) per 
dibuixar les trajectòries pel mètode de Heun.