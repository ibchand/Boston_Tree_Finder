%getLocation.m

%Called by: NearestButton, RandomButtom
%Calls: N/A
%Inputs: N/A
%Returns: LatO(double),LongO(double)
%IP Address Site is Used
%IP to Coordinates Site is Used

%{
getLocation takes no inputs. It then uses webread to read information from
a site that provides your IP address. It then uses webread again to read
information from another site with a URL that contains the IP we received
previously. It then takes the information needed, the latitude and
longitude, which it then returns.
%} 

function [LatO,LongO] = getLocation()
    
    %Calls webread to read content from URL, getting IP address
    IP=regexp(webread('http://checkip.dyndns.org'),'(\d+)(\.\d+){3}','match');
    
    %Sets IP to IP address
    IP=IP{1}; %string
    
    %Calls webread to read content from URL, getting coordinates
    info=webread('https://tools.keycdn.com/geo.json?host={',IP,'}');
    
    %Sets LatO equal to Latitude
    LatO=info.data.geo.latitude;
    
    %Sets LongO equal to Longitude
    LongO=info.data.geo.longitude;
    
 end