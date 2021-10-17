% Bikewheel - Matlabproject in Engineering Science Course

function F = Bikewheel(r,s) % r=Radius s=Speed
pMax = 200; resolution = 70; acceleration = [1;-9.8]/resolution;
p = zeros(4,pMax); n = 0; % Particle #n: 1:2=Pos 3:4=Vel

% Camera Declarations
A = [0 1.5 0 1]*r*s; F = struct('cdata',[],'colormap',[]); frame = 0;
figure('color','w'), set(figure(1),'Position',[800 300 500 300])

% Drawing Declarations
HubX = r+r*.2; HubY = r*1.02; T = rand(1)*2*pi; % T(Theta)=Rotation
TirX = cos(linspace(0,2*pi,50))*r; TirY = sin(linspace(0,2*pi,50))*r;

while (n < pMax || any(p(1,:) < A(2))), frame = frame+1;
    if (n < pMax) % Release new particle?
        n = n+1; angle = (rand(1)*0.45+.05)*pi;
        p(1:2,n) = [cos(angle-pi/2)*r+HubX;sin(angle-pi/2)*r+HubY];
        p(3:4,n) = [cos(angle);sin(angle)]*s;
    end, hold on
    
    % Update particles: Pos += Vel & Vel += Acc
    for i = 1:n, if(p(1,i) > A(2)+5), continue, end
        if (p(2,i) <= 0), p(1,i) = p(1,i)+s/resolution;
        else, p(1:2,i) = p(1:2,i)+p(3:4,i)/resolution;
        	  p(3:4,i) = p(3:4,i)+acceleration;
        end, plot(p(1,i),max(p(2,i),0),'or','MarkerSize',2);
    end, T = T+(s/r)/resolution;
    
    % Draw Bike in order: Tire, Spokes, Reflex, 5xFrame & Seat
    plot(TirX+HubX,TirY+HubY,'k','LineWidth',3*r);
    for i = 1:20
        plot([0 cos(i*pi/10+T)]*r+HubX,[0 sin(i*pi/10+T)]*r+HubY,'k');
    end, plot(cos(pi/10+T)*.8*r+HubX,sin(pi/10+T)*.8*r+HubY,'*b');
    plot([0 HubX],[HubY HubY],'k','LineWidth',2*r);
    plot([0 HubX/2],[.3 1.3]*r+HubY,'k','LineWidth',2*r);
    plot([0 HubX/2],[1 1]*HubY+1.3*r,'k','LineWidth',2*r);
    plot([1/2 1]*HubX,[1.3*r 0]+HubY,'k','LineWidth',2*r);
    plot([1 1]/2*HubX,[1.3 1.5]*r+HubY,'k','LineWidth',2*r);
    plot([.2 .6]*HubX,[1.5 1.5]*r+HubY,'k','LineWidth',6*r);
    
    plot(A(1:2),[0 0],'k'); axis(A), set(gca,'visible','off')
    hold off, F(frame) = getframe(); clf
end