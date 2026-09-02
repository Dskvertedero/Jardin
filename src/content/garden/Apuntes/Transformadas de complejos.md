---
categoria: Compleja
descripcion: 2 de septiembre 2026
---

Ahora incluiré mis apuntes también en parte, así será más fácil para mí acceder a mis notas de clase desde aquí.

Lo cual me recuerda inevitablemente a lo que vi en espacios vectoriales 2, a fin de cuentas es aplicar una transformada a estos números complejos.  
  
Solo con la diferencia que estos, en vez de ser trabajados con una matriz, se hará de forma directa, de forma operacional.  
  
No puedo creer que en serio volví a abrir el libro de Álgebra Lineal, puedo escuchar las palabras del doctor Abel mientras vuelvo a leer el libro. En fin.  
  
Me llama la atención porque claro, si quiero rotar algo le aplico una matriz, específicamente esta matriz:  
$$  
R_\theta =  
\begin{pmatrix}  
\cos\theta & -\sin\theta \\  
\sin\theta & \cos\theta  
\end{pmatrix}  
$$  
  
y de hecho hice cuentas y sí, funciona perfectamente. Si al número z=2+3i le quiero aplicar una rotación de 40∘, le aplico la matriz:  
$$  
  
\begin{pmatrix}  
x'\\  
y'  
\end{pmatrix}  
=  
\begin{pmatrix}  
\cos 40^\circ & -\sin 40^\circ\\  
\sin 40^\circ & \cos 40^\circ  
\end{pmatrix}  
\begin{pmatrix}  
2\\  
3  
\end{pmatrix}  
  
$$  
  
$$  
\begin{pmatrix}  
2\cos 40^\circ - 3\sin 40^\circ\\  
2\sin 40^\circ + 3\cos 40^\circ  
\end{pmatrix}  
$$  
  
$$  
\begin{pmatrix}  
-0.3963\\  
3.5836  
\end{pmatrix}  
$$  
  
$$  
\boxed{R_{40^\circ}(2+3i)\approx -0.3963+3.5836i}  
  
  
$$  
![[Pasted image 20260902012258.png]]  
  
y pues sí da eso.  
  
Lo curioso es que también se puede hacer con la forma exponencial de un número complejo. Ahora no sé cuál sea más eficiente, pero será interesante ver cómo se desenvuelven ambas maneras en diferentes problemas.  
  
Es simple, demasiado tal vez, demasiado.  
$$  
z=R e^{i\theta}+e^{i\beta}=Re^{i(\theta+\beta)}  
$$  
  
asi aplicando el mismo problema pero con su fomra potencial sera:  
  
$$  
z=\sqrt{13}e^{i\beta},  
\qquad  
\beta=\arctan\left(\frac{3}{2}\right)  
$$  
primero sacar angulo y modulo  
$$  
R_{40^\circ}(z)  
=  
e^{i40^\circ}z  
$$  
  
$$  
=  
e^{i40^\circ}\sqrt{13}e^{i\beta}  
$$  
  
$$  
=  
\sqrt{13}e^{i(40^\circ+\beta)}  
$$  
  
$$  
=  
\sqrt{13}e^{i\left(40^\circ+\arctan\left(\frac{3}{2}\right)\right)}  
$$  
O sea, sí, muy bonito, pero si quiero volver a mi número de antes ahora tengo que hacer esto otro:  
  
$$  
  
R_{40^\circ}(z)  
=  
\sqrt{13}  
\left[  
\cos\left(40^\circ+\arctan\left(\frac{3}{2}\right)\right)  
+  
i\sin\left(40^\circ+\arctan\left(\frac{3}{2}\right)\right)  
\right]  
$$  
  
$$  
\boxed{  
R_{40^\circ}(z)\approx -0.3963+3.5836i  
}  
$$  
Ahora, en ambos casos, sí o sí necesito usar la calculadora porque aún no puedo hacer eso a mano.  
  
AA, acabo de pensar si realmente hay alguna relación entre ambas formas y claramente que la hay.  
  
Bien, partiendo de nuevo desde la forma matricial:  
  
$$  
  
\begin{pmatrix}  
x'\\  
y'  
\end{pmatrix}  
=  
\begin{pmatrix}  
\cos \theta & -\sin \theta\\  
\sin \theta & \cos \theta  
\end{pmatrix}  
\begin{pmatrix}  
x\\  
y  
\end{pmatrix}  
  
$$  
  
Extiendo al operación a sistema de ecuaciones queda  
  
$$  
x´ =x\cos\theta- y\sin\theta  
$$  
$$  
y´=x\sin \theta + y\cos \theta  
$$  
y claro esto si reescribo x y y en su forma polar es como si quedara  
_$$  
x´=r \cos\beta \cos\theta - r \sin\beta \sin\theta  
$$  
$$  
y´=r \cos\beta\sin \theta +r \sin\beta\cos\theta  
$$  
  
Ahora pues es claro que coscos-sinsin y cossen+sincos, corresponden a las identidades cos(a+b) y sin(a+b), ya reescrito todo queda como  
  
$$  
x´=r\cos(\theta+\beta)  
$$  
$$  
y´=\sin(\theta+\beta)  
$$  
duh. Perdi mucho tiempo haciendo esto

2 de septiembre 2026