function cvx_optpnt = simplex( sx, dim )

%SIMPLEX   The unit simplex.
%    SIMPLEX(N), where N is a positive integer, creates a column vector
%    variable of length N whose elements are constrained to be nonnegative
%    and whose sum is constrained to be one. That is, given the declaration
%        variable x(n)
%    the constraint
%        x == simplex(n)
%    is equivalent to
%        x >= 0;
%        sum(x) == 1;
%
%    SIMPLEX(SX,DIM), where SX is a valid non-empty size vector, creates a
%    CVX array variable of size SX and DIM is a positive integer, creates
%    a CVX array of size SX and applies the simplex constraint along the
%    dimension DIM. That is, given the declaration
%        variable x(sx)
%    the constraint
%        x == simplex(sx,dim)
%    is equivalent to
%        x >= 0;
%        sum(sx,dim) == 1;
%    If DIM is not supplied, then the first non-singleton dimension of SX
%    will be chosen.
%
%   Disciplined convex programming information:
%       SIMPLEX is a cvx set specification. See the user guide for
%       details on how to use sets.

%
% Check size vector
%

error( nargchk( 1, 2, nargin ) );
[ temp, sx ] = cvx_check_dimlist( sx, false );
if ~temp,
    error( 'First argument must be a dimension vector.' );
end
nd = length( sx );

%
% Check dimension
%

if nargin < 2 | isempty( dim ),
    dim = [ find( sx > 1 ), 1 ];
    dim = dim( 1 );
elseif ~isnumeric( dim ) | dim < 0 | dim ~= floor( dim ),
    error( 'Second argument must be a dimension.' );
elseif dim > nd,
    sx( end + 1 : dim ) = 1;
    nd = dim;
end

%
% Construct set
%

cvx_begin_set
   variables x( sx )
   sum( x, dim ) == 1;
   x >= 0;
cvx_end_set

% Copyright 2008 Michael C. Grant and Stephen P. Boyd. 
% See the file COPYING.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
