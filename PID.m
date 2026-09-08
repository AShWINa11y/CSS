clc;
clear ;
close all;
s=tf('s');
num=[45];
dn=[1 7 45];

G=tf(num,dn);
C={1,pidtune(G,'P'),pidtune(G,'PD'),pidtune(G,'PI'),pidtune(G,'PID')};
T={feedback(C{1}*G,1),feedback(C{2}*G,1),feedback(C{3}*G,1),feedback(C{4}*G,1),feedback(C{5}*G,1)};
figure;
step(T{:},10);
legend('no control','P','PD','PI','PID','Location','best');
title('step response:no control vs P,PD,PI,PID CONTROLLER');
grid on;