%% Reto Proyectiles
clc
clear
format short g

% Valores pedidos al usuario
k = double(input("Ingrese la constante de amortiguamiento (resistencia del aire): "));
v0 = double(input("Ingrese la velocidad inicial: "));
angulo = double(input("Ingrese el ángulo de salida del proyectil: "));

% Valores predeterminados
g = 9.81;
altura = 2500;
masa = 10;
deltaT = 0.1;
t0 = 0;
tf = 100;
t = t0:deltaT:tf;

% Valores obtenidos con fórmulas
vx = v0*cosd(angulo);     % velocidad inicial en x
vy = v0*sind(angulo);     % velocidad inicial en x
Fx=-k*vx;                 % Fuerza de resistencia
Fy=-masa*g-k*vy;          % Suma de todas las fuerzas en y
ax=Fx/masa;               % Aceleración en x
ay=Fy/masa;               % Aceleración en y

% Valores iniciales
ax(1) = ax;
ay(1) = ay;
vx(1) = vx;
vy(1) = vy;
x(1) = 0;
y(1) = altura;

% Ciclo para calcular los valores de la gráfica
n = int32((tf-t0)/deltaT);
for i =1:n
    vx(i+1) = vx(i)+ ax(i)*deltaT;    % Euler
    Fx(i+1) = -(k) * vx(i+1);         % Resistencia del aire
    ax(i+1) = Fx(i+1)/masa;           % 2da Ley de Newton
    vy(i+1) = vy(i)+ ay(i)*deltaT;    % Euler
    Fy(i+1) = -(masa*g)-(k*vy(i+1));  % Suma de fuerzas en y
    ay(i+1) = Fy(i+1)/masa;           % 2da Ley de Newton
    x(i+1)= x(i) + vx(i)*deltaT;      % Euler
    y(i+1) = y(i) + vy(i)*deltaT;     % Euler
   
     
    
end

% Crear la gáfica
plot(x,y)
hold on
p = plot(x(1),y(1),'o','MarkerFaceColor','red');
axis([1 5000 1 5000])
grid on
xlabel('X (Distancia)')
ylabel('Y (Altura)')
title('Simulación de Proyectil')
hold off


for k = 1:length(x)
    if y(k)>0    
        % Mover un Marker a lo largo de una curva por actualizar las propiedades XData y YData
        p.XData = x(k);
        p.YData = y(k);
        

        % Actualizar datos
        altura_max=max(y);
        txt_altura = ['Altura Maxima: ',num2str(altura_max),' m'];
        taltura = text(100,200,txt_altura);
      
        txt_dy=['Punto en Y: ' num2str(y(k)) ' m'];
        tdy= text(2500,4000,txt_dy);
        txt_dx=['Punto en X: ' num2str(x(k)) ' m'];
        tdx=text(100,4000,txt_dx);  
        
        vel_maxX=vx(k);
        vel_maxY=vy(k);

        txt_velx=['Velocidad en X:' num2str(vel_maxX) ' m/s'];
        tvx = text(100,4500,txt_velx);
        txt_vely=['Velocidad en Y:' num2str(vel_maxY) ' m/s'];
        tvy = text(2500,4500,txt_vely); 
        
        punto_impacto= x(k);

          

        drawnow
        delete(taltura)
        delete(tdy);
        delete(tdx);
        delete(tvx);
        delete(tvy);
        
    end

end

clc

disp("El punto de impacto es en : " + num2str(punto_impacto) + " m")

% Valores utilizados para la simulación
disp("Valores de los parámetros utilizados durante la simulación:");
t=t';
vx=vx';
vy=vy';
Fx=Fx';
Fy=Fy';
ax=ax';
ay=ay';
T=table(t,vx,vy,Fx,Fy,ax,ay);
disp("Gravedad: "+num2str(g)+ " m/s^2")
disp("Altura: "+num2str(altura)+ " m")
disp("Masa: "+num2str(masa)+ " kg")
disp("Cambio en el tiempo: "+num2str(deltaT))
disp("Tiempo inicial: "+num2str(t0)+ " s")
disp("Tiempo final: "+num2str(tf)+ " s")
disp("Velocidad Inicial: "+num2str(v0)+ " m/s")
disp("Ángulo: "+num2str(angulo)+ "°")
disp(T)


  










