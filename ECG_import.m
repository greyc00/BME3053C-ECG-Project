function data = ECG_import(filename, dataLines)
%IMPORTFILE Import data from a text file
%  PATIENT104RAW = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  PATIENT104RAW = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  patient104raw = importfile("C:\Users\bengr\OneDrive\Documents\MATLAB\database\patient104_raw.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated for Benjamin Arnold by MATLAB on 14-Nov-2022 17:09:00

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [3, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 33);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Time", "Var2", "Var3", "Vz", "Var5", "vy", "Var7", "vx", "Var9", "v6", "Var11", "v5", "Var13", "v4", "Var15", "v3", "Var17", "v2", "Var19", "v1", "Var21", "avf", "Var23", "avl", "Var25", "avr", "Var27", "iii", "Var29", "ii", "Var31", "i", "Var33"];
opts.SelectedVariableNames = ["Time", "Vz", "vy", "vx", "v6", "v5", "v4", "v3", "v2", "v1", "avf", "avl", "avr", "iii", "ii", "i"];
opts.VariableTypes = ["double", "string", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string", "double", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var5", "Var7", "Var9", "Var11", "Var13", "Var15", "Var17", "Var19", "Var21", "Var23", "Var25", "Var27", "Var29", "Var31", "Var33"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var2", "Var3", "Var5", "Var7", "Var9", "Var11", "Var13", "Var15", "Var17", "Var19", "Var21", "Var23", "Var25", "Var27", "Var29", "Var31", "Var33"], "EmptyFieldRule", "auto");

% Import the data
data = readtable(filename, opts);

end