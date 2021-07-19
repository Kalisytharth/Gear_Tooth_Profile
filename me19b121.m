
m = 10;
P_angle = pi/9;
z=20;

r_p=100;
r_b = r_p*cos(P_angle);

r_y = linspace(r_b,r_p + m,100);  %General circle

angle_y =zeros(1,100);
tooth_thick=zeros(1,100);
theta=zeros(1,100);
x=zeros(1,100);
y=zeros(1,100);

%Involute
for i=1:100
    angle_y(i)=acos(r_b/r_y(i));
    tooth_thick(i)=2*r_y(i).*((pi/(2*z))+tan(P_angle)-P_angle-tan(angle_y(i))+angle_y(i));
    theta(i)= tooth_thick(i)/r_y(i);
    x(i)=r_y(i)*sin(theta(i));
    y(i)=r_y(i)*cos(theta(i));
end

% Non Involute
x_0 = 16.76;

x_1=linspace(x_0,x(1),100);
y_1=(y(1)-y(2))/(x(1)-x(2)).*(x_1-x(1))+y(1);

%Dedendum to Base
X=linspace(-x(1),-y_1(1),50);
Y=sqrt(((r_p - 1.25*m)^2)-X.^2);  
x=cat(2,x_1,x,-fliplr(x),-fliplr(x_1),X);
y=cat(2,y_1,y,fliplr(y),fliplr(y_1),Y);

%Rotation Matrix
angle_rotation=pi/2;
M=[cos(angle_rotation) -sin(angle_rotation);sin(angle_rotation) cos(angle_rotation)];

r1=M*[x;y];
r2=M*r1;
r3=M*r2;

x=cat(2,x,r1(1,:),r2(1,:),r3(1,:));
y=cat(2,y,r1(2,:),r2(2,:),r3(2,:));

plot(x,y);

