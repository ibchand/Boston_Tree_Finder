%getData.m

%Called by: MapButton,NearestButton,RandomButton
%Calls: N/A
%Inputs: N/A
%Returns: data(Table)

%{
drawMap take 1 table as an input. It the plots data from the table using
'.' as a marker and sets the color of the marker to green.
%}

function data=getData()

    %Calls webread to read the content from the dataset site
    data = webread('http://bostonopendata-boston.opendata.arcgis.com/datasets/ce863d38db284efe83555caf8a832e2a_1.csv');

end