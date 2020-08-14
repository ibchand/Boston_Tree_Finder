%getDist.m

%Called by: getTree()
%Calls: N/A
%Inputs: LatO(double),LongO(double),LatD(double),LongD(double),Mode(string)
%Returns: dist(double),address(cell),URL(string)
%Google Distance Matrix API is Used

%{
getDist takes 4 doubles and 1 string as inputs. It then casts the 4 
doubles to strings. It then uses those strings to create a functional URL. 
That URL is then passed to the webread() function and the data is stored 
and information is extracted. That information is then returned.
%}

function [dist,address,time,URL]= getDist(LatO,LongO,LatD,LongD,Mode)
    %Casts double coordinate values to strings
    LatO=num2str(LatO,10); %string
    LongO=num2str(LongO,10); %string
    LatD=compose("%f",LatD); %string
    LongD=compose("%f",LongD); %string

    %Intial segment and Mode segment
    seg1=strcat("https://maps.googleapis.com/maps/api/distancematrix/json?units=standard&mode=",Mode); %string

    %Origin Coordinates segment
    seg2=strcat("&origins=",LatO,",",LongO); %string

    %Destination Coordinates segment
    destCoords=strcat(LatD,",",LongD); %string
    destCoords=strjoin(destCoords,"|"); %string
    seg3=strcat("&destinations=",destCoords); %string

    %Key segment
    seg4='&key=AIzaSyBqJZf1_MVej01qmWAyr-tg435x_sqwWsE'; %string

    %Concatenates segments into complete URL
    URL=strcat(seg1,seg2,seg3,seg4); %string & return value

    %Calls webread to read content from URL
    info=webread(URL); %structure
    
    %Stores distance data from info in dist
    dist=[info.rows.elements(:).distance];
    dist=[dist(:).value]; %double & return value
    
    %Stores time data from info in time
    time=[info.rows.elements(:).duration];
    time={time(:).text};
    
    %Stores address data from info in address
    address=info.destination_addresses; %cell & return value
    
end