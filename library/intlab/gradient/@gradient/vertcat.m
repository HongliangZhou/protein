function c = vertcat(varargin)
%VERTCAT      Implements  [a(1) ; a(2) ; ...]  for gradients
%

% written  10/16/98     S.M. Rump
% modified 04/04/04     S.M. Rump  set round to nearest for safety
% modified 04/06/05     S.M. Rump  rounding unchanged
%

  a = gradient(varargin{1});
  c.x = a.x.';
  [m n] = size(a.x);
  index = reshape( 1:(m*n) , m , n )';
  c.dx = a.dx( index(:) , : );

  for i=2:length(varargin)
    a = gradient(varargin{i});
    c.x = [ c.x a.x.' ];
    [m n] = size(a.x);
    index = reshape( 1:(m*n) , m , n )';
    c.dx = [ c.dx ; a.dx( index(:) , : ) ];   % arrays stored columnwise
  end
  [m n] = size(c.x);
  index = reshape( 1:(m*n) , m , n )';
  c.x = c.x.';
  c.dx = c.dx( index(:) , : );

  c = class(c,'gradient');
  