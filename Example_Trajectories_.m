

load(['E:\data\ExampleFlight.mat']);
load coast

%#############################################
%#############################################

figure
hold on
h1 = geoshow(lat,long,'LineWidth',1.5);
for ii = 1:140
   eval(['plot(trajis.t' num2str(ii) '.lon(1:121), trajis.t' num2str(ii) '.lat(1:121),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
   hold on
end;
grid
axis([-160 -40 -30 30])
set(h1,'Color',[0.2078 0.2078 0.5451])
xlabel('Longitude','FontSize',20,'FontName','Times New Roman')
ylabel('Latitude','FontSize',20,'FontName','Times New Roman')

%#############################################
%#############################################

set(findobj('Type','axes'),'LineWidth',2,'FontSize',20,'FontName','Times New Roman')
set(findobj('Type','figure'),'PaperPositionMode','auto','Units','pixels','Position',[79 88 1064 629])
set(findobj('Type','figure'),'PaperUnits','inches','PaperPosition',[-0.336207 2.7931 9.17241 5.42241])

ff=findobj('type','figure');
for i=1:length(ff);
    figure(ff(i));
    set(gcf,'color','w');
    box('on');
end;

%#############################################
%#############################################

print(1,'-dpng','-r300','Trajectories.png')

