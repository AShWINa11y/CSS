s=tf('s');
% Till transfer function (eg: 0.84195/(0.01554*s^(3) + 0.583*s^(2) + s + 1.119796)
G =(0.3726/((s*(1+0.0147*s)*(1+0.5505*s)) + 0.85698));
a=step(G);
figure;
plot(a);
ylim([0 1.2]);
grid on;