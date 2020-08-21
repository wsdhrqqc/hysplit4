

load(['ExampleShip_1801.mat']);
load coast

%#############################################
%#############################################

figure
% hold on
% plot 
plot(lon(1:300),latt(1:300),'LineWidth',3)
h1 = geoshow(lat,long,'LineWidth',1.5);

hold on
for ii = 1:10:300
    if any(eval(['trajis.t' num2str(ii) '.lon'])<60)>0
       
    %    eval(['plot(trajis.t' num2str(ii) '.lon(1:121), trajis.t' num2str(ii) '.lat(1:121),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
%    eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
        eval(['plot(trajis.t' num2str(ii) '.lon(1:60), trajis.t' num2str(ii) '.lat(1:60),''LineWidth'',1);']);
%         hold on
    else
        eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''LineWidth'',1);']);
%         hold on
    end
end;

for ii = 300:40:700
    if any(eval(['trajis.t' num2str(ii) '.lon'])<60)>0
       
    %    eval(['plot(trajis.t' num2str(ii) '.lon(1:121), trajis.t' num2str(ii) '.lat(1:121),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
%    eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
        eval(['plot(trajis.t' num2str(ii) '.lon(1:60), trajis.t' num2str(ii) '.lat(1:60),''LineWidth'',1);']);
%         hold on
    else
        eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''LineWidth'',1);']);
%         hold on
    end
end;

% for ii = 1000:20:2000
% %    eval(['plot(trajis.t' num2str(ii) '.lon(1:121), trajis.t' num2str(ii) '.lat(1:121),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
% %    eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''Color'',[0.9137 0.3412 0.149],''LineWidth'',1);']);
%    eval(['plot(trajis.t' num2str(ii) '.lon(1:end), trajis.t' num2str(ii) '.lat(1:end),''LineWidth'',1);']);
%    hold on
% end;
grid
% axis([-160 -40 -30 30])% left right down top
axis([30 175 -80 -30])% left right down top
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


% %%%%
% for i = 1:3668
% if any(eval(['trajis.t' num2str(i) '.lon'])<60)>0
% disp(num2str(i))
% end
% end

