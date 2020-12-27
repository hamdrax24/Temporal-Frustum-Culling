///frustum_culling(pojection view matrix);
var plane = frustum_extract_plane(argument0);

for(var ii = 0;ii < boxcount;ii++)
{
    var boxindex = ii * 3,
    _x = boxposition[@ boxindex],
    _y = boxposition[@ boxindex + 1],
    _z = boxposition[@ boxindex + 2],
    _ex = boxextent[@ boxindex],
    _ey = boxextent[@ boxindex + 1],
    _ez = boxextent[@ boxindex + 2],
    inside = true;
        
    for(var count = 0;(count < 24) && inside;count+=4)
    {
        var
        px = plane[count + Plane.A],
        py = plane[count + Plane.B],
        pz = plane[count + Plane.C],
        pw = plane[count + Plane.D];
        
        inside &= ((_x * px) + (_y * py) + (_z * pz))
                + (abs(_ex * px) + abs(_ey * py) + abs(_ez * pz))
                >= -pw;
    };
    
    if(inside)
    {
        var writeindex = culled_boxes * 3;
        drawposition[@ writeindex] = _x;
        drawposition[@ writeindex + 1] = _y;
        drawposition[@ writeindex + 2] = _z;
        drawextent[@ writeindex] = _ex;
        drawextent[@ writeindex + 1] = _ey;
        drawextent[@ writeindex + 2] = _ez;
        culled_boxes++;
    }
}; 
