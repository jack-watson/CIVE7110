
%% CIVE7110 - 17 September 2024

randtool()

%% CIVE7110 - 19 September 2024

% Q1. ---------------------------------------------------------------------

% in command window (equivalent of below, xf == future_value):
future_value = 24*(1+(1.5/100))^(2025-1626);

x0 = 24; % principal
r = 1.5/100; % rate
tspan = 2025 - 1626; % timespan in years

xf = x0*(1+r)^tspan; % future value


% Q2. ---------------------------------------------------------------------

% Q1.1
% in command window (equivalent to below, arr == rrAnn(2)):
arr = (1/3500)*70e9; % = $20,000,000

RPs = [103, 3500]; % return periods
dmg = 70e9; % $70 billion in damage
ip = 25; % 25 year investment period

rrAnn = (1./RPs).*dmg;

% Q1.2
% equivalent to below (npv_rr == npv_rr2):
ir = 2/100;
npv_rr = arr*((((1+ir)^25) - 1)/(ir*(1+ir)^25));

% creating a function named NPV which takes in two arguments, i (interest
% rate) and n (investment period in years). This lets you call NPV(i,n)
% instead of writing out the whole equation repeatedly each time you want
% to calculate net present value.
NPV = @(i,n) ((1+i).^n - 1)./(i.*(1+i).^n); 
npv_rr2 = arr*NPV(ir,tspan);

% Bonus: getting accustomed to MATLAB syntax ------------------------------
% NPV is written in element-wise array notation, so i and n can be scalars
% (e.g., 1/50, 25) or arrays (e.g., [1/50, 1/75, 1/100, 1/1000], [10, 25,
% 50, 100]).

% The above example is equivalent to running NPV four times: NPV(1/50, 10),
% NPV(1/75, 25), NPV(1/100, 50), NPV(1/1000, 100). This means that i and n 
% must be equal in dimensions, OR one of the two must be a scalar; in this
% case they're both of dimensions (1,4).
% Observe:
NPV([1/50, 1/75, 1/100, 1/1000], [10, 25, 50, 100])

% To compare different investment periods (n) while keeping the interest
% rate constant, you can do:
NPV(0.02, [10, 25, 50, 100, 200, 500, 1000])

% If you want to run calculations for *every* whole-year investment period
% between 5 and 100 years, you can use the notation 5:100 to generate an
% array of integers starting at 5 and ending at 100 (96 values). See:
NPV(0.02, 5:100)

% If you want to do the same but sample every 6 months rather than every
% year, you can use the notation 5:(1/2):100 or 5:0.5:100 (191 values).
NPV(0.02, 5:(1/2):100)