///scr_camera_create(x,y,z, speed);
d3d_start();
//d3d_set_culling(true);
d3d_set_hidden(true);
draw_set_colour(c_white);
texture_set_repeat(true);
    
bearing = 0;
pitch = 0;
vector_x = 0;
vector_y = 0;
vector_z = 0;

x = argument0;
y = argument1;
cam_z = argument2;

max_speed = argument3;

znear = 1;
zfar = 5000;
zrange = zfar - znear;
fov = 60;
tanfov = tan(degtorad(fov)/2);
aspect = view_wview[0]/view_hview[0];
