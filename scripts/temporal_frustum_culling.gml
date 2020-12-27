///temporal_frustum_culling(pojection view matrix, max frametime);
var plane = frustum_extract_plane(argument0);

var index = 0, shiftedboxes = 0;
while(index < ds_list_size(culled_list))
{
    var boxindex = culled_list[| index], boxoffset = boxindex * 3,
    _x = boxposition[@ boxoffset],
    _y = boxposition[@ boxoffset + 1],
    _z = boxposition[@ boxoffset + 2],
    _ex = boxextent[@ boxoffset],
    _ey = boxextent[@ boxoffset + 1],
    _ez = boxextent[@ boxoffset + 2],
    cullindex = culloffset[@ boxindex],
    inside = true;
        
    for(var count = 0;count < 6;count++)
    {
        var
        px = plane[cullindex + Plane.A],
        py = plane[cullindex + Plane.B],
        pz = plane[cullindex + Plane.C],
        pw = plane[cullindex + Plane.D];
        
        inside &= ((_x * px) + (_y * py) + (_z * pz))
                + (abs(_ex * px) + abs(_ey * py) + abs(_ez * pz))
                >= -pw;
        
        if(!inside)
        {
            break;
        }
        
        cullindex = (cullindex + 4) % 24;
    };
    
    if(inside)
    {
        ds_list_delete(culled_list,index);
        ds_list_add(unculled_list,boxindex);
    }
    
    culloffset[@ boxindex] = cullindex;
    shiftedboxes += inside;
    index += !inside;
}; 

var dt_timer = get_timer(), loop_count = ds_list_size(unculled_list) - shiftedboxes;
while((loop_count > 0) && (get_timer() - dt_timer) < argument1)
{
    var boxindex = unculled_list[| 0], boxoffset = boxindex * 3,
    _x = boxposition[@ boxoffset],
    _y = boxposition[@ boxoffset + 1],
    _z = boxposition[@ boxoffset + 2],
    _ex = boxextent[@ boxoffset],
    _ey = boxextent[@ boxoffset + 1],
    _ez = boxextent[@ boxoffset + 2],
    cullindex = 0, inside = true;
        
    for(var count = 0;(count < 6);count++)
    {
        var
        px = plane[cullindex + Plane.A],
        py = plane[cullindex + Plane.B],
        pz = plane[cullindex + Plane.C],
        pw = plane[cullindex + Plane.D];
        
        inside &= ((_x * px) + (_y * py) + (_z * pz))
                + (abs(_ex * px) + abs(_ey * py) + abs(_ez * pz))
                >= -pw;
        
        if(!inside)
        {
            break;
        }
        
        cullindex += 4;
    };
    
    ds_list_delete(unculled_list,0);
    
    var listwrite = (inside * unculled_list) + (!inside * culled_list);
    ds_list_add(listwrite,boxindex)
    
    culloffset[@ boxindex] = cullindex;
    shiftedboxes += inside;
    loop_count--;
};

culled_boxes = ds_list_size(unculled_list);
for(var ii = 0;ii < culled_boxes;ii++)
{
    var writeindex = ii * 3;
    index = unculled_list[| ii] * 3;
    drawposition[@ writeindex] = boxposition[@ index];
    drawposition[@ writeindex + 1] = boxposition[@ index + 1];
    drawposition[@ writeindex + 2] = boxposition[@ index + 2];
    drawextent[@ writeindex] = boxextent[@ index];
    drawextent[@ writeindex + 1] = boxextent[@ index + 1];
    drawextent[@ writeindex + 2] = boxextent[@ index + 2];
}
