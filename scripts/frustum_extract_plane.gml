///frustum_extract_plane(matrix m)
enum FrustumPlanes {
    Left = 0,
    Right = 1,
    Top = 2,
    Bottom = 3,
    Near = 4,
    Far = 5,
};

var mat = argument0, p = array_create(24);

///Left plane
p[@ Plane.A] = mat[3] + mat[0];
p[@ Plane.B] = mat[7] + mat[4];
p[@ Plane.C] = mat[11] + mat[8];
p[@ Plane.D] = mat[15] + mat[12];

///Right plane
p[@ 4 + Plane.A] = mat[3] - mat[0];
p[@ 4 + Plane.B] = mat[7] - mat[4];
p[@ 4 + Plane.C] = mat[11] - mat[8];
p[@ 4 + Plane.D] = mat[15] - mat[12];

///Top plane
p[@ 8 + Plane.A] = mat[3] - mat[1];
p[@ 8 + Plane.B] = mat[7] - mat[5];
p[@ 8 + Plane.C] = mat[11] - mat[9];
p[@ 8 + Plane.D] = mat[15] - mat[13];

///Bottom plane
p[@ 12 + Plane.A] = mat[3] + mat[1];
p[@ 12 + Plane.B] = mat[7] + mat[5];
p[@ 12 + Plane.C] = mat[11] + mat[9];
p[@ 12 + Plane.D] = mat[15] + mat[13];

///Near plane
p[@ 16 + Plane.A] = mat[2];
p[@ 16 + Plane.B] = mat[6];
p[@ 16 + Plane.C] = mat[10];
p[@ 16 + Plane.D] = mat[14];

///Far plane
p[@ 20 + Plane.A] = mat[3] - mat[2];
p[@ 20 + Plane.B] = mat[7] - mat[6];
p[@ 20 + Plane.C] = mat[11] - mat[10];
p[@ 20 + Plane.D] = mat[15] - mat[14];

for(var ii = 0;ii < 6;ii++)
{
    var index = ii * 4;
    length = sqrt(sqr(p[@ index + Plane.A]) + sqr(p[@ index + Plane.B]) + sqr(p[@ index + Plane.C]));
    p[@ index + Plane.A] /= length;
    p[@ index + Plane.B] /= length;
    p[@ index + Plane.C] /= length;
    p[@ index + Plane.D] /= length;
}

return p;
